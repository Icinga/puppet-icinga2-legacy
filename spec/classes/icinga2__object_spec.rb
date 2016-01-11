require 'spec_helper'
require 'variants'

describe 'icinga2::object' do

  os = 'debian-8-x86_64'
  context "on #{os}" do
    let(:facts) do
      on_supported_os[os]
    end

    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::object') }
    it { should contain_class('icinga2') }

    it { should contain_icinga2__object__apiuser('admin') }
    it { should contain_icinga2__object__apply_dependency('testdependency') }
    it { should contain_icinga2__object__apply_notification_to_host('hostnotification') }
    it { should contain_icinga2__object__apply_notification_to_service('servicenotification') }
    it { should contain_icinga2__object__apply_service('oldservice') }
    it { should contain_icinga2__object__apply_service('service') }
    it { should contain_icinga2__object__checkcommand('test') }
    it { should contain_icinga2__object__dependency('testdependency2') }
    it { should contain_icinga2__object__eventcommand('test') }
    it { should contain_icinga2__object__graphitewriter('test') }
    it { should contain_icinga2__object__hostgroup('test') }
    it { should contain_icinga2__object__host('testhost') }
    it { should contain_icinga2__object__idomysqlconnection('test') }
    it { should contain_icinga2__object__idopgsqlconnection('test') }
    it { should contain_icinga2__object__notificationcommand('test') }
    it { should contain_icinga2__object__notification('test') }
    it { should contain_icinga2__object__perfdatawriter('test') }
    it { should contain_icinga2__object__scheduleddowntime('test') }
    it { should contain_icinga2__object__servicegroup('test') }
    it { should contain_icinga2__object__service('test') }
    it { should contain_icinga2__object__timeperiod('test') }
    it { should contain_icinga2__object__usergroup('test') }
    it { should contain_icinga2__object__user('test') }
    it { should contain_icinga2__object__zone('test') }
  end
end
