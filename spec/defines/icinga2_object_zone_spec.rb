require 'spec_helper'
require 'variants'

describe 'icinga2::object::zone' do

  on_supported_os.each do |os, facts|

    context "on #{os} with basic parameters" do
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
          :name => 'testzone',
          :endpoints => {
            'endpoint1' => {},
            'endpoint2' => {}
          },
          :file_name => 'testzone.conf',
        }
      end

      it { should contain_icinga2__object__zone('testzone') }
      it { should contain_file('icinga2 object zone testzone').with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/zones/testzone.conf',
            :content => /object Zone "testzone"/,
          }) }
      it { should contain_file('icinga2 object zone testzone').with_content(/^\s*endpoints = \[\n\s+"endpoint1",\n\s+"endpoint2",\n\s+\]$/) }

      it { should contain_icinga2__object__endpoint('endpoint1') }
      it { should contain_icinga2__object__endpoint('endpoint2') }
    end

    context "on #{os} with parent" do
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
          :name => 'testzone',
          :endpoints => {
            'endpoint1' => {},
            'endpoint2' => {}
          },
          :file_name => 'testzone.conf',
          :parent => 'testmaster'
        }
      end

      it { should contain_icinga2__object__zone('testzone') }
      it { should contain_file('icinga2 object zone testzone').with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/zones/testzone.conf',
            :content => /object Zone "testzone"/,
          }) }
      it { should contain_file('icinga2 object zone testzone').with_content(/^\s*endpoints = \[\n\s+"endpoint1",\n\s+"endpoint2",\n\s+\]$/) }
      it { should contain_file('icinga2 object zone testzone').with_content(/^\s*parent = "testmaster"$/) }

      it { should contain_icinga2__object__endpoint('endpoint1') }
      it { should contain_icinga2__object__endpoint('endpoint2') }
    end

    context "on #{os} as global zone" do
      let :facts do
        facts
      end
      let :pre_condition do
        "class { 'icinga2':
        }"
      end

      let(:title) { 'global-zone' }
      let(:params) do
        {
          :name => 'global-zone',
          :global => true,
        }
      end

      it { should contain_icinga2__object__zone('global-zone') }
      it { should contain_file('icinga2 object zone global-zone').with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/zones/global-zone.conf',
            :content => /object Zone "global-zone"/,
          }) }
      it { should contain_file('icinga2 object zone global-zone').without_content(/^\s*endpoints = /) }
      it { should contain_file('icinga2 object zone global-zone').with_content(/^\s*global = true$/) }
    end

    context "on #{os} as global zone with parent or endpoints" do
      let :facts do
        facts
      end
      let :pre_condition do
        "class { 'icinga2':
        }"
      end

      let(:title) { 'global-zone' }
      let(:params) do
        {
          :name => 'global-zone',
          :parent => 'master',
          :global => true,
        }
      end

      it { should raise_error(Puppet::Error, /global zones can\'t have/) }
    end

    context "on #{os} with all parameters" do
      pending
    end
  end
end
