require 'spec_helper'
require 'variants'

describe 'icinga2::server' do

  IcingaPuppet.variants.each do |name, facts|

    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      it { should compile }
      it { should contain_class('icinga2::server') }
      it { should contain_class('icinga2') }
      it { should contain_class('icinga2::params') }
    end

  end

end
