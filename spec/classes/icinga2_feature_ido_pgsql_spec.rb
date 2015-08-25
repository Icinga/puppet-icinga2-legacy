require 'spec_helper'
require 'variants'

describe 'icinga2::feature::ido_pgsql' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
   let :pre_condition do
      "class { 'icinga2': }"
    end

    it { should contain_class('icinga2::feature::ido_pgsql') }
    it { should contain_icinga2__feature('ido-pgsql') }
    it { should contain_icinga2__object__idopgsqlconnection('ido-pgsql') }
    it { should contain_file('/etc/icinga2/features-available/ido-pgsql.conf').with({
      :path    => '/etc/icinga2/features-available/ido-pgsql.conf',
      :content => /database = "icinga2_data"/,
    })}
    it { should contain_file('/etc/icinga2/features-available/ido-pgsql.conf').without_content(/port =/) }
    it { should contain_file('/etc/icinga2/features-available/ido-pgsql.conf') }
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

    it { should contain_class('icinga2::feature::ido_pgsql') }
    it { should contain_icinga2__feature('ido-pgsql') }
    it { should contain_icinga2__object__idopgsqlconnection('ido-pgsql') }
    it { should contain_file('/etc/icinga2/features-available/ido-pgsql.conf').with({
      :path    => '/etc/icinga2/features-available/ido-pgsql.conf',
      :content => /database = "foobar"/,
    })}
  end

end
