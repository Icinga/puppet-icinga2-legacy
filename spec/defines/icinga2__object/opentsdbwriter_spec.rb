require 'spec_helper'
require 'variants'

describe 'icinga2::object::opentsdbwriter', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'opentsdbtestserver' }

      object_file = '/etc/icinga2/features-available/opentsdbtestserver.conf'
      it { should contain_icinga2__object__opentsdbwriter('opentsdbtestserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/opentsdbtestserver.conf',
            :content => /object OpenTsdbWriter "opentsdbtestserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "127.0.0.1"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 4242$/) }

    end
    context "on #{name} with non basic parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :host => 'www.icinga.org',
        :port => '1234',
      }
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'opentsdbtest2server' }

      object_file = '/etc/icinga2/features-available/opentsdbtest2server.conf'
      it { should contain_icinga2__object__opentsdbwriter('opentsdbtest2server') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/features-available/opentsdbtest2server.conf',
            :content => /object OpenTsdbWriter "opentsdbtest2server"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "www.icinga.org"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 1234$/) }
    end
  end
end
