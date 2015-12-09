require 'beaker-rspec'

hosts.each do |host|
  # Install Puppet
  install_puppet()
end

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'icinga2')

    hosts.each do |host|
      if fact('osfamily') == 'Debian'
        on host, puppet('module','install','puppetlabs-apt'), { :acceptable_exit_codes => [0,1] }
      end
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end

    if fact('osfamily') == 'Debian'
      pp = <<-EOS
      class { '::apt': }
      apt::source { 'icinga':
        location    => 'http://packages.icinga.org/debian/',
        release     => "icinga-${::lsbdistcodename}",
        repos       => 'main',
        key_source  => 'http://packages.icinga.org/icinga.key',
        key         => '34410682',
        include_src => false,
        pin         => '1000'
      }
      EOS

      apply_manifest_on(hosts, pp, :catch_failures => false)
    end
  end
end
