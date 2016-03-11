require 'spec_helper'
require 'variants'

describe 'icinga2::feature' do

  default = 'Debian wheezy'

  context "on default #{default} with default parameters" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :pre_condition do
      "class { 'icinga2':
        default_features => false,
      }"
    end

    let(:title) { 'checker' }

    it { should contain_icinga2__feature('checker') }
    it { should contain_file('icinga2 feature checker').with({
      :ensure => 'file',
      :path => '/etc/icinga2/features-available/checker.conf',
      :content => /CheckerComponent/,
    })}
    it { should contain_file('icinga2 feature checker enabled').with({
      :ensure => 'link',
      :path   => '/etc/icinga2/features-enabled/checker.conf',
      :target => '../features-available/checker.conf',
    })}
    it { is_expected.to contain_file("icinga2 feature checker").that_notifies('Class[icinga2::service]') }
  end

  context "on default #{default} with file not managed" do
    let :facts do
      IcingaPuppet.variants[default]
    end
    let :params do
      {
        :manage_file => false,
      }
    end
    let :pre_condition do
      "class { 'icinga2':
        default_features => false,
      }"
    end

    let(:title) { 'checker' }

    it { should contain_icinga2__feature('checker') }
    it { should_not contain_file('icinga2 feature checker')}
    it { should contain_file('icinga2 feature checker enabled').with({
      :ensure => 'link',
      :path => '/etc/icinga2/features-enabled/checker.conf',
    })}
    it { is_expected.not_to contain_file("icinga2 feature checker").that_notifies('Class[icinga2::service]') }
  end


end
