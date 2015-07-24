require 'spec_helper'
require 'variants'

describe 'icinga2::nrpe' do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      it { should compile }
      it { should contain_class('::icinga2::nrpe') }
      it { should contain_class('::icinga2::params') }
    end
  end
end
