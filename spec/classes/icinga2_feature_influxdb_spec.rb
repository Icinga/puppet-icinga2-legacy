require 'spec_helper'
require 'variants'

describe 'icinga2::feature::influxdb' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "include '::icinga2'"
    end

    it { should contain_class('icinga2::feature::influxdb') }
    it { should contain_icinga2__object__influxdbwriter('influxdb') }
    it { should contain_icinga2__feature('influxdb').with({
            :manage_file => false,
       }) }
    it { should contain_file('/etc/icinga2/features-available/influxdb.conf').with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/influxdb.conf',
            :content => /object InfluxdbWriter "influxdb"/,
       }) }
  end
end
