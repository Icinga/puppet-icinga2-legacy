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
        default_features => [],
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
        default_features => [],
      }"
    end

    let(:title) { 'checker' }

    it { should contain_icinga2__feature('checker') }
    it { should_not contain_file('icinga2 feature checker')}
    it { should contain_file('icinga2 feature checker enabled').with({
      :ensure => 'link',
      :path => '/etc/icinga2/features-enabled/checker.conf',
    })}
  end


end
