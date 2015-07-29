require 'spec_helper'
require 'variants'

describe 'icinga2::object::zone' do

  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        "class { 'icinga2':
        }"
      end

      let(:title) { 'testzone' }

      # TODO: should be removed with refactoring
      let(:params) do
        {
          :object_name => 'testzone',
          :endpoints => ['endpoint1', 'endpoint2'],
          :target_file_name => 'testzone.conf',
        }
      end

      object_file = '/etc/icinga2/objects/zones/testzone.conf'
      it { should contain_icinga2__object__zone('testzone') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/zones/testzone.conf',
            :content => /object Zone "testzone"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*endpoints = \[\s+"endpoint1",\s+"endpoint2", \]$/) }

    end

    context "on #{name} with parent" do
      let :facts do
        facts
      end
      let :pre_condition do
        "class { 'icinga2':
        }"
      end

      let(:title) { 'testzone' }

      let(:params) do
        {
          :object_name => 'testzone',
          :endpoints => ['endpoint1', 'endpoint2'],
          :target_file_name => 'testzone.conf',
          :parent => 'testmaster'
        }
      end

      object_file = '/etc/icinga2/objects/zones/testzone.conf'
      it { should contain_icinga2__object__zone('testzone') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/zones/testzone.conf',
            :content => /object Zone "testzone"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*endpoints = \[\s+"endpoint1",\s+"endpoint2", \]$/) }
      it { should contain_file(object_file).with_content(/^\s*parent = "testmaster"$/) }
    end

    context "on #{name} with all parameters" do
      pending
    end
  end
end
