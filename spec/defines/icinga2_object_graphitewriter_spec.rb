require 'spec_helper'
require 'variants'

describe 'icinga2::object::graphitewriter', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'graphitetestserver' }

      object_file = '/etc/icinga2/objects/graphitewriters/graphitetestserver.conf'
      it { should contain_icinga2__object__graphitewriter('graphitetestserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/graphitewriters/graphitetestserver.conf',
            :content => /object GraphiteWriter "graphitetestserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "127.0.0.1"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 2003$/) }

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
        "include 'icinga2'"
      end

      let(:title) { 'graphite2testserver' }

      object_file = '/etc/icinga2/objects/graphitewriters/graphite2testserver.conf'
      it { should contain_icinga2__object__graphitewriter('graphite2testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/graphitewriters/graphite2testserver.conf',
            :content => /object GraphiteWriter "graphite2testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "www.icinga.org"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 1234$/) }
      it { should_not contain_file(object_file).with_content(/^\s*host_name_template/) }
      it { should_not contain_file(object_file).with_content(/^\s*service_name_template/) }
      it { should_not contain_file(object_file).with_content(/^\s*enable_send_thresholds/) }
      it { should_not contain_file(object_file).with_content(/^\s*enable_send_metadata/) }

    end
    context "on #{name} with more non basic parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :host => 'www.icinga.org',
        :port => '1234',
        :host_name_template => 'icinga.$host.name$',
        :service_name_template => 'icinga.$host.name$.$service.name$',
        :enable_send_thresholds => true,
        :enable_send_metadata => false,
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'graphite2testserver' }

      object_file = '/etc/icinga2/objects/graphitewriters/graphite2testserver.conf'
      it { should contain_icinga2__object__graphitewriter('graphite2testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/graphitewriters/graphite2testserver.conf',
            :content => /object GraphiteWriter "graphite2testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "www.icinga.org"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 1234$/) }
      it { should contain_file(object_file).with_content(/^\s*host_name_template = icinga.\$host.name\$$/) }
      it { should contain_file(object_file).with_content(/^\s*service_name_template = icinga.\$host.name\$.\$service.name\$$/) }
      it { should contain_file(object_file).with_content(/^\s*enable_send_thresholds = true$/) }
      it { should contain_file(object_file).with_content(/^\s*enable_send_metadata = false$/) }
    end
  end
end
