require 'spec_helper'
require 'variants'

describe 'icinga2::nrpe' do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      let :nrpe_daemon_name do
        facts[name]['nrpe_daemon_name']
      end

      it { should compile }
      it { should contain_class('icinga2::nrpe') }
      it { should contain_class('icinga2::nrpe::service') }
      it { should contain_class('icinga2::params') }
      it { should contain_service('nrpe').with(:name => facts[:nrpe_daemon_name]) }
    end
  end
end
