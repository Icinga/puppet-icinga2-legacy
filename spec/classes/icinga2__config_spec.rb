require 'spec_helper'
require 'variants'

describe 'icinga2::config' do

  default = 'Debian wheezy'

  context "on #{default} with default parameters" do
    let :facts do
      IcingaPuppet.variants[default]
    end

    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::config') }

    it { should contain_class('icinga2::feature::checker') }
    it { should contain_class('icinga2::feature::notification') }
    it { should contain_class('icinga2::feature::mainlog') }

    pending
  end

  context "on default #{default} without default features" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2':
        default_features => false,
      }"
    end

    it { should contain_class('icinga2::config') }

    it { should_not contain_icinga2__feature('checker') }
    it { should_not contain_icinga2__feature('notification') }
    it { should_not contain_icinga2__feature('mainlog') }
  end

end
