require 'spec_helper_acceptance'

describe 'icinga2::server' do

  before :all do
    on default, puppet('module','install','puppetlabs-postgresql')
  end

  context 'with defaults' do
    it 'should idempotently run' do
      pp = <<-EOS
      class { 'postgresql::server': }
      ->
      postgresql::server::db { 'icinga2_data':
        user     => 'icinga2',
        password => postgresql_password('icinga2', 'password'),
      }
      ->
      class { '::icinga2::server':
        manage_repos    => false,
        server_db_type  => 'pgsql',
        use_debmon_repo => false,
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
