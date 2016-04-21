require 'spec_helper'
require 'variants'

describe 'icinga2::object::checkcommand' do
  let(:title) do
    'spectest'
  end

  let(:facts) do
    IcingaPuppet.variants['Debian wheezy']
  end

  let(:params) do
    {
      :command => [ 'check_test' ],
    }
  end

  let(:pre_condition) do
    'include ::icinga2'
  end

  context 'with basic values' do
    it { should contain_icinga2__object__checkcommand('spectest') }

    pending
  end

  context "with parameter command = array with one item" do

    let(:title) { 'testcheckcommand' }

    let(:params) do
      {
        :object_checkcommandname => 'testcheckcommand',
        :command => [ 'testcommand1']
      }
    end

    object_file = '/etc/icinga2/objects/checkcommands/testcheckcommand.conf'
    it { should contain_icinga2__object__checkcommand('testcheckcommand') }
    it { should contain_file(object_file).with_content(/^\s*command = \[ PluginDir \+ "testcommand1" \]$/) }

  end

  context "with parameter command = array with more than one item" do

    let(:title) { 'testcheckcommand' }

    let(:params) do
      {
        :object_checkcommandname => 'testcheckcommand',
        :command => [ 'testcommand1' , 'argument1', 'argument2' ]
      }
    end

    object_file = '/etc/icinga2/objects/checkcommands/testcheckcommand.conf'
    it { should contain_icinga2__object__checkcommand('testcheckcommand') }
    it { should contain_file(object_file).with_content(/^\s*command = \[ PluginDir \+ "testcommand1", "argument1", "argument2" \]$/) }

  end

  context "with sudo = true and sudo_cmd = /usr/bin/sudo" do

    let(:title) { 'testcheckcommand' }

    let(:params) do
      {
        :object_checkcommandname => 'testcheckcommand',
        :command => [ 'testcommand1', 'testcommand2'],
        :sudo => 'true',
      }
    end

    object_file = '/etc/icinga2/objects/checkcommands/testcheckcommand.conf'
    it { should contain_icinga2__object__checkcommand('testcheckcommand') }
    it { should contain_file(object_file).with_content(/^\s*command = \[ "\/usr\/bin\/sudo", PluginDir \+ "testcommand1", "testcommand2" \]$/) }

  end

end
