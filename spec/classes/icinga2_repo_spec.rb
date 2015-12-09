require 'spec_helper'
require 'variants'

describe 'icinga2::repo' do

  context "on Debian" do
    let :facts do
      IcingaPuppet.variants['Debian wheezy']
    end
    it { should contain_class('icinga2::repo::apt') }
  end

  context "on RedHat" do
    let :facts do
      IcingaPuppet.variants['RedHat 6']
    end
    it { should contain_class('icinga2::repo::yum') }
  end
end
