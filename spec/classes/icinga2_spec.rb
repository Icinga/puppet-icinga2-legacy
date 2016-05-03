require 'spec_helper'
require 'variants'

describe 'icinga2' do

  IcingaPuppet.variants.each do |name, facts|

    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      it { should compile }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
    end

    context "on #{name} with manage_database on" do
      let(:facts) {
        facts
      }

      let(:params) {
        {:manage_database => true}
      }

      it { should compile }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
      it { should contain_class('icinga2::database') }
    end

    context "on #{name} with mysql example" do
      let(:facts) {
        facts
      }

      let(:params) {
        {
          :manage_database => true,
          :db_type => 'mysql',
        }
      }

      it { should compile }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
      it { should contain_class('icinga2::database') }
      it { should contain_class('icinga2::feature::ido_mysql') }
      it { should contain_icinga2__object__idomysqlconnection('ido-mysql') }
    end

    context "on #{name} with pgsql example" do
      let(:facts) {
        facts
      }

      let(:params) {
        {
          :manage_database => true,
          :db_type => 'pgsql',
        }
      }

      it { should compile }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
      it { should contain_class('icinga2::database') }
      it { should contain_class('icinga2::feature::ido_pgsql') }
      it { should contain_icinga2__object__idopgsqlconnection('ido-pgsql') }
    end


    context "on #{name} with manage_database off" do
      let(:facts) {
        facts
      }

      let(:params) {
        {:manage_database => false}
      }

      it { should compile }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
      it { should_not contain_class('icinga2::database') }
    end
  end

  # TODO: move to other spec when refactoring
  context 'on Debian wheezy with debmon.org' do
    let :facts do
      IcingaPuppet.variants['Debian wheezy']
    end
    let :params do
      {
        :use_debmon_repo => true,
      }
    end

    it { should compile }
    it { should contain_class('icinga2') }
    it { should contain_class('icinga2::params') }
  end

end
