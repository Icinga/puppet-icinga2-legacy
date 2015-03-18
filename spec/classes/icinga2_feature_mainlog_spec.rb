require 'spec_helper'
require 'variants'

describe 'icinga2::feature::mainlog' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::mainlog') }
    it { should contain_icinga2__feature('mainlog') }
    it { should contain_file('icinga2 feature mainlog').with({
      :content => /severity = "information"\n\s+path = "\/var\/log\/icinga2\/icinga2\.log"/,
    })}
  end

  context "on #{default} with changed parameters" do
    let :pre_condition do
      "class { 'icinga2':
        default_features => [],
      }
      class { 'icinga2::feature::mainlog':
        severity => 'debug',
        path     => '/tmp/icinga2.log',
      }"
    end

    it { should contain_class('icinga2::feature::mainlog') }
    it { should contain_icinga2__feature('mainlog') }
    it { should contain_file('icinga2 feature mainlog').with({
      :content => /severity = "debug"\n\s+path = "\/tmp\/icinga2\.log"/,
    })}
  end

end
