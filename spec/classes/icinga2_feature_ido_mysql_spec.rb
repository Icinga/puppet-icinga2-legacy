require 'spec_helper'
require 'variants'

describe 'icinga2::feature::ido_mysql' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::ido_mysql') }
    it { should contain_icinga2__feature('ido-mysql') }
    it { should contain_icinga2__object__idomysqlconnection('ido-mysql') }
    it { should contain_file('icinga2 object idomysqlconnection ido-mysql').with({
      :path    => '/etc/icinga2/features-available/ido-mysql.conf',
      :content => /database = "icinga2_data"/,
    })}
    it { should contain_file('icinga2 object idomysqlconnection ido-mysql').without_content(/port =/) }
    it { should contain_file('icinga2 feature ido-mysql enabled') }
  end

  context "on #{default} with changed parameters" do
    let :params do
      {
        :database => 'foobar',
      }
    end
    let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::ido_mysql') }
    it { should contain_icinga2__feature('ido-mysql') }
    it { should contain_icinga2__object__idomysqlconnection('ido-mysql') }
    it { should contain_file('icinga2 object idomysqlconnection ido-mysql').with({
      :path    => '/etc/icinga2/features-available/ido-mysql.conf',
      :content => /database = "foobar"/,
    })}
  end

end
