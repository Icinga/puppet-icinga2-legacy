require 'spec_helper'
require 'variants'

describe 'icinga2::feature::command' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::command') }
    it { should contain_icinga2__feature('command') }
    it { should contain_file('icinga2 feature command').without_content(/command_path/) }
  end

  context "on #{default} with changed parameters" do
    let :pre_condition do
      "class { 'icinga2':
      }
      class { 'icinga2::feature::command':
        command_path => '/tmp/icinga2.cmd',
      }"
    end

    it { should contain_class('icinga2::feature::command') }
    it { should contain_icinga2__feature('command') }
    it { should contain_file('icinga2 feature command').with({
      :content => /command_path = "\/tmp\/icinga2\.cmd"/,
    })}
  end

end
