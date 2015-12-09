require 'spec_helper_acceptance'

describe 'icinga2' do

  before :all do
    on default, puppet('module','install','puppetlabs-mysql')
  end

  context 'with MySQL database as IDO backend' do
    it 'should idempotently run' do
      pp = <<-EOS
      class { 'mysql::server': }
      ->
      mysql::db { 'icinga2_data':
        user     => 'icinga2',
        password => 'password',
      }
      ->
      class { '::icinga2':
        manage_repos    => false,
        manage_database => true,
        db_type         => 'mysql',
        use_debmon_repo => false,
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
