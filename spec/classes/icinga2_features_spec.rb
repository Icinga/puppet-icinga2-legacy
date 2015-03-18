require 'spec_helper'
require 'variants'

describe 'icinga2::features' do

  default = 'Debian wheezy'

  context "on default #{default} with default parameters" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::features') }
    it { should contain_icinga2__feature('checker') }
    it { should contain_class('icinga2::feature::notification') }
    it { should contain_class('icinga2::feature::mainlog') }
  end

  context "on default #{default} with other default features" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2':
        default_features => [ 'checker' ],
      }"
    end

    it { should contain_class('icinga2::features') }
    it { should contain_icinga2__feature('checker') }
    it { should_not contain_icinga2__feature('notification') }
  end

end
