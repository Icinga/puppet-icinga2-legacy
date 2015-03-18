require 'spec_helper'
require 'variants'

describe 'icinga2::feature::notification' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::notification') }
    it { should contain_icinga2__feature('notification') }
    it { should contain_file('icinga2 feature notification').with({
      :content => /enable_ha = true/,
    })}
  end

  context "on #{default} with changed parameters" do
    let :pre_condition do
      "class { 'icinga2':
        default_features => [],
      }
      class { 'icinga2::feature::notification':
        enable_ha => false,
      }"
    end

    it { should contain_class('icinga2::feature::notification') }
    it { should contain_icinga2__feature('notification') }
    it { should contain_file('icinga2 feature notification').with({
      :content => /enable_ha = false/,
    })}
  end

end
