require 'spec_helper'
require 'variants'

describe 'icinga2::install' do

  context "on Debian" do
    let :facts do
      IcingaPuppet.variants['Debian wheezy']
    end

    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::install') }
    it { should contain_package('icinga2') }
    it { should contain_package('nagios-plugins') }
    it { should contain_package('mailutils') }
  end

  context "on RedHat" do
    let :facts do
      IcingaPuppet.variants['RedHat 6']
    end

    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::install') }
    it { should contain_package('icinga2') }
    it { should contain_package('nagios-plugins-all') }
    it { should contain_package('mailx') }
  end
end
