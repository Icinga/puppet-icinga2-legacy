require 'spec_helper'
require 'variants'

describe 'icinga2::object::gelfwriter', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'gelftestserver' }

      object_file = '/etc/icinga2/features-available/gelftestserver.conf'
      it { should contain_icinga2__object__gelfwriter('gelftestserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/gelftestserver.conf',
            :content => /object GelfWriter "gelftestserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "127.0.0.1"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 12201$/) }
      it { should_not contain_file(object_file).with_content(/^\s*source/) }

    end
    context "on #{name} with basic parameters and source" do
      let :facts do
        facts
      end
      let :params do
      {
        :source => 'icinga2gelf',
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'gelftestserver' }

      object_file = '/etc/icinga2/features-available/gelftestserver.conf'
      it { should contain_icinga2__object__gelfwriter('gelftestserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/gelftestserver.conf',
            :content => /object GelfWriter "gelftestserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "127.0.0.1"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 12201$/) }
      it { should contain_file(object_file).with_content(/^\s*source = "icinga2gelf"$/) }

    end
  end
end
