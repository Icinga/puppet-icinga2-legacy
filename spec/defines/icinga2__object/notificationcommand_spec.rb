require 'spec_helper'
require 'variants'

describe 'icinga2::object::notificationcommand' do
  let(:title) do
    'spectest'
  end

  let(:facts) do
    IcingaPuppet.variants['Debian wheezy']
  end

  let(:params) do
    {
      :command => [ 'notify_test' ],
    }
  end

  let(:pre_condition) do
    'include ::icinga2'
  end

  context 'with basic values' do
    it { should contain_icinga2__object__notificationcommand('spectest') }

    pending
  end

  context "with parameter command = array with one item" do

    let(:title) { 'testnotificationcommand' }

    let(:params) do
      {
        :object_notificationcommandname => 'testnotificationcommand',
        :command => [ 'testcommand1']
      }
    end

    object_file = '/etc/icinga2/objects/notificationcommands/testnotificationcommand.conf'
    it { should contain_icinga2__object__notificationcommand('testnotificationcommand') }
    it { should contain_file(object_file).with_content(/^\s*command = \[ PluginDir \+ "testcommand1" \]$/) }

  end

  context "with parameter command = array with more than one item" do

    let(:title) { 'testnotificationcommand' }

    let(:params) do
      {
        :object_notificationcommandname => 'testnotificationcommand',
        :command => [ 'testcommand1' , 'testcommand2']
      }
    end

    object_file = '/etc/icinga2/objects/notificationcommands/testnotificationcommand.conf'
    it { should contain_icinga2__object__notificationcommand('testnotificationcommand') }
    it { should contain_file(object_file).with_content(/^\s*command = \[ PluginDir \+ "testcommand1", PluginDir \+ "testcommand2" \]$/) }

  end

end
