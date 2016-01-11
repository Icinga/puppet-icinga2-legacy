require 'spec_helper'
require 'variants'

describe 'icinga2::service' do

  context "on Debian" do
    let :facts do
      IcingaPuppet.variants['Debian wheezy']
    end

    it { should contain_class('icinga2::service') }
    it { should contain_exec('icinga2 config stamp') }
    it { should contain_exec('icinga2 daemon config test') }
    it { should contain_service('icinga2').with({
      :ensure => 'running',
    })}
  end
  context "on Debian with service restart command" do
    let :facts do
      IcingaPuppet.variants['Debian wheezy']
    end
    let :pre_condition do
      "class { 'icinga2':
        restart_cmd => 'service icinga2 reload'
       }"
    end

    it { should contain_class('icinga2::service') }
    it { should contain_exec('icinga2 config stamp') }
    it { should contain_exec('icinga2 daemon config test') }
    it { should contain_service('icinga2').with({
      :ensure => 'running',
      :hasrestart => 'true',
      :restart => 'service icinga2 reload'
    })}
  end
end
