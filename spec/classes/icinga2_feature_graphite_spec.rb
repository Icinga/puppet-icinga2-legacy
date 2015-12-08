require 'spec_helper'
require 'variants'

describe 'icinga2::feature::graphite' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "include '::icinga2'"
    end

    it { should contain_class('icinga2::feature::graphite') }
    it { should contain_icinga2__object__graphitewriter('graphite') }
    it { should contain_icinga2__feature('graphite').with({
            :manage_file => false,
       }) }
    it { should contain_file('/etc/icinga2/features-available/graphite.conf').with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/graphite.conf',
            :content => /object GraphiteWriter "graphite"/,
       }) }
  end
end
