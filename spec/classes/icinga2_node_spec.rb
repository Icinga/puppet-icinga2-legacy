require 'spec_helper'
require 'variants'

describe 'icinga2::node' do

  IcingaPuppet.variants.each do |name, facts|

    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      it { should compile }
      it { should contain_class('icinga2::node') }
      it { should contain_class('icinga2::params') }
    end

  end

end
