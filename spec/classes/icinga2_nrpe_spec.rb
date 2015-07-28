require 'spec_helper'
require 'variants'

describe 'icinga2::nrpe' do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      it { should compile }
    end
  end
end
