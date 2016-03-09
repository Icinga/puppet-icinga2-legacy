require 'spec_helper'
require 'variants'

describe 'icinga2::object::apiuser' do


  on_supported_os.each do |os, facts|

    context "on #{os} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'testuser' }

      object_file = '/etc/icinga2/objects/apiusers/testuser.conf'
      it { should contain_icinga2__object__apiuser('testuser') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/apiusers/testuser.conf',
            :content => /object ApiUser "testuser"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*permissions = /) }
    end

    context "on #{os} with some parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'testuser2' }

      let(:params) do
        {
          :password => 'secret',
          :client_cn => 'testuser123',
        }
      end

      object_file = '/etc/icinga2/objects/apiusers/testuser2.conf'
      it { should contain_icinga2__object__apiuser('testuser2') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/apiusers/testuser2.conf',
            :content => /object ApiUser "testuser2"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*permissions = /) }
      it { should contain_file(object_file).with_content(/^\s*password = "secret"$/) }
      it { should contain_file(object_file).with_content(/^\s*client_cn = "testuser123"$/) }
    end
  end
end
