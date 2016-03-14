require 'spec_helper'
require 'variants'

describe 'icinga2::object::user' do
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
    it { should contain_icinga2__object__user('spectest') }

    pending
  end

  context "with parameter is_template=true" do

    let(:title) { 'testuser' }

    let(:params) do
      {
        :object_username => 'testuser',
        :display_name => 'testuser',
        :target_file_name => 'testuser.conf',
        :is_template => true,
      }
    end

    object_file = '/etc/icinga2/objects/users/testuser.conf'
    it { should contain_icinga2__object__user('testuser') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/users/testuser.conf',
          :content => /template User "testuser"/,
        }) }
    it { should_not contain_file(object_file).with_content(/^\s*import "testuser"$/) }

  end

  context "with parameter is_template=true and import templates" do

    let(:title) { 'testuser' }

    let(:params) do
      {
        :object_username => 'testuser',
        :display_name => 'testuser',
        :target_file_name => 'testuser.conf',
        :is_template => true,
        :templates => [ 'testuser' , 'generic-user']
      }
    end

    object_file = '/etc/icinga2/objects/users/testuser.conf'
    it { should contain_icinga2__object__user('testuser') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/users/testuser.conf',
          :content => /template User "testuser"/,
        }) }
    it { should_not contain_file(object_file).with_content(/^\s*import "testuser"$/) }
    it { should contain_file(object_file).with_content(/^\s*import "generic-user"$/) }

  end

end
