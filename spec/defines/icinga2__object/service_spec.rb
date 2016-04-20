require 'spec_helper'
require 'variants'

describe 'icinga2::object::service' do
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
    it { should contain_icinga2__object__service('spectest') }

    pending
  end

  context "with parameter is_template=true" do

    let(:title) { 'testservice' }

    let(:params) do
      {
        :object_servicename => 'testservice',
        :display_name => 'testservice',
        :target_file_name => 'testservice.conf',
        :is_template => true,
      }
    end

    object_file = '/etc/icinga2/objects/services/testservice.conf'
    it { should contain_icinga2__object__service('testservice') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/services/testservice.conf',
          :content => /template Service "testservice"/,
        }) }
    it { should_not contain_file(object_file).with_content(/^\s*import "testservice"$/) }

  end

  context "with parameter is_template=true and import templates" do

    let(:title) { 'testservice' }

    let(:params) do
      {
        :object_servicename => 'testservice',
        :display_name => 'testservice',
        :target_file_name => 'testservice.conf',
        :is_template => true,
        :templates => [ 'testservice' , 'generic-service']
      }
    end

    object_file = '/etc/icinga2/objects/services/testservice.conf'
    it { should contain_icinga2__object__service('testservice') }
    it { should contain_file(object_file).with({
          :ensure => 'file',
          :path => '/etc/icinga2/objects/services/testservice.conf',
          :content => /template Service "testservice"/,
        }) }
    it { should_not contain_file(object_file).with_content(/^\s*import "testservice"$/) }
    it { should contain_file(object_file).with_content(/^\s*import "generic-service"$/) }

  end

  context "with parameter command_endpoint" do

    let(:title) { 'testservice' }

    let(:params) do
      {
        :object_servicename => 'testservice',
        :display_name => 'testservice',
        :target_file_name => 'testservice.conf',
        :command_endpoint => 'testservice.example.com'
      }
    end

    object_file = '/etc/icinga2/objects/services/testservice.conf'
    it { should contain_icinga2__object__service('testservice') }
    it { should contain_file(object_file).with_content(/^\s*import "generic-service"$/) }
    it { should contain_file(object_file).with_content(/^\s*command_endpoint = "testservice.example.com"$/) }

  end

end
