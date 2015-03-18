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
