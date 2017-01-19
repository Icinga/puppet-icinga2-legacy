require 'spec_helper'
require 'variants'

describe 'icinga2::object::apply_notification_to_service' do
  let(:title) do
    'spectest'
  end

  let(:facts) do
    IcingaPuppet.variants['Debian wheezy']
  end

  let(:params) do
    {}
  end

  let(:pre_condition) do
    'include ::icinga2'
  end

  context 'with basic values' do
    it { should contain_icinga2__object__apply_notification_to_service('spectest') }

    pending
  end

  context 'with parameter users and user_groups = array' do
    let(:params) do
      {
        :users => [ 'user1', 'user2' ],
        :user_groups => [ 'group1', 'group2' ]
      }
    end

    object_file = '/etc/icinga2/objects/applys/spectest.conf'
    it { should contain_icinga2__object__apply_notification_to_service('spectest') }
    it { should contain_file(object_file).with_content(/^\s*users = \[ "user1", "user2" \]$/) }
    it { should contain_file(object_file).with_content(/^\s*user_groups = \[ "group1", "group2" \]$/) }
  end

  context 'with parameter users and user_groups = string' do
    let(:params) do
      {
        :users => 'vars.users',
        :user_groups => 'vars.groups',
      }
    end

    object_file = '/etc/icinga2/objects/applys/spectest.conf'
    it { should contain_icinga2__object__apply_notification_to_service('spectest') }
    it { should contain_file(object_file).with_content(/^\s*users = vars.users$/) }
    it { should contain_file(object_file).with_content(/^\s*user_groups = vars.groups$/) }
  end

  context 'with basic values' do
    it { should contain_icinga2__object__apply_notification_to_service('spectest') }

    pending
  end

end
