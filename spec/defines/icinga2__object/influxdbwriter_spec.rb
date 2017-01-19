require 'spec_helper'
require 'variants'

describe 'icinga2::object::influxdbwriter', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'influxdbtestserver' }

      object_file = '/etc/icinga2/objects/influxdbwriters/influxdbtestserver.conf'
      it { should contain_icinga2__object__influxdbwriter('influxdbtestserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/influxdbwriters/influxdbtestserver.conf',
            :content => /object InfluxdbWriter "influxdbtestserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "127.0.0.1"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 8086$/) }

    end
    context "on #{name} with non basic parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :host => 'www.icinga.org',
        :database => 'icingasuperDB',
        :port => '1234',
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'influxdb2testserver' }

      object_file = '/etc/icinga2/objects/influxdbwriters/influxdb2testserver.conf'
      it { should contain_icinga2__object__influxdbwriter('influxdb2testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/influxdbwriters/influxdb2testserver.conf',
            :content => /object InfluxdbWriter "influxdb2testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "www.icinga.org"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 1234$/) }
      it { should contain_file(object_file).with_content(/^\s*database = "icingasuperDB"$/) }
      it { should contain_file(object_file).with_content(/^\s*host_template = {/) }
      it { should contain_file(object_file).with_content(/^\s*service_template = {/) }
      it { should_not contain_file(object_file).with_content(/^\s*enable_send_thresholds/) }
      it { should_not contain_file(object_file).with_content(/^\s*enable_send_metadata/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_enable = true/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_enable = false/) }

    end
    context "on #{name} with more non basic parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :host => 'www.icinga.org',
        :port => '1234',
        :database => 'icingaTESTdb',
        :ssl_enable => false,
        :enable_send_thresholds => true,
        :enable_send_metadata => false,
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'influxdb2testserver' }

      object_file = '/etc/icinga2/objects/influxdbwriters/influxdb2testserver.conf'
      it { should contain_icinga2__object__influxdbwriter('influxdb2testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/influxdbwriters/influxdb2testserver.conf',
            :content => /object InfluxdbWriter "influxdb2testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host = "www.icinga.org"$/) }
      it { should contain_file(object_file).with_content(/^\s*port = 1234$/) }
      it { should contain_file(object_file).with_content(/^\s*database = "icingaTESTdb"$/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_enable = true$/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_ca_cert$/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_cert$/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_key$/) }
      it { should_not contain_file(object_file).with_content(/^\s*ssl_enable = false$/) }
      it { should contain_file(object_file).with_content(/^\s*enable_send_thresholds = true$/) }
      it { should contain_file(object_file).with_content(/^\s*enable_send_metadata = false$/) }
    end
    context "on #{name} with influxdb ssl_enable == true parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :ssl_enable => true,
        :ssl_ca_cert => '/etc/sslca.crt',
        :ssl_cert => '/etc/sslcert.crt',
        :ssl_key  => '/etc/sslkey.key',
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'influxdb3testserver' }

      object_file = '/etc/icinga2/objects/influxdbwriters/influxdb3testserver.conf'
      it { should contain_icinga2__object__influxdbwriter('influxdb3testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/influxdbwriters/influxdb3testserver.conf',
            :content => /object InfluxdbWriter "influxdb3testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*ssl_enable = true$/) }
      it { should contain_file(object_file).with_content(/^\s*ssl_ca_cert = "\/etc\/sslca.crt"$/) }
      it { should contain_file(object_file).with_content(/^\s*ssl_cert = "\/etc\/sslcert.crt"$/) }
      it { should contain_file(object_file).with_content(/^\s*ssl_key = "\/etc\/sslkey.key"$/) }
    end
    context "on #{name} with custom template parameters" do
      let :facts do
        facts
      end
      let :params do
      {
        :host_template => '{
    measurement = "$host.vars.measurement$"
    tags = {
      host = "$host.display_name$"
      system = "$host.vars.system$"
    }
}',
        :service_template => '{
    measurement = "$service.vars.measurement$"
    tags = {
      host = "$host.display_name$"
      service = "$service.display_name$"
      type = "$service.vars.type$"
    }
}',
      }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'influxdb4testserver' }

      object_file = '/etc/icinga2/objects/influxdbwriters/influxdb4testserver.conf'
      it { should contain_icinga2__object__influxdbwriter('influxdb4testserver') }
      it { should contain_file(object_file).with({
            :ensure => 'file',
            :path => '/etc/icinga2/objects/influxdbwriters/influxdb4testserver.conf',
            :content => /object InfluxdbWriter "influxdb4testserver"/,
          }) }
      it { should contain_file(object_file).with_content(/^\s*host_template = {\n\s*measurement = "\$host.vars.measurement\$"\n\s*tags = {\n\s*host = "\$host.display_name\$"\n\s*system = "\$host.vars.system\$"\n\s*}\n\s*}$/) }
      it { should contain_file(object_file).with_content(/^\s*service_template = {\n\s*measurement = "\$service.vars.measurement\$"\n\s*tags = {\n\s*host = "\$host.display_name\$"\n\s*service = "\$service.display_name\$"\n\s*type = "\$service.vars.type\$"\n\s*}\n\s*}$/) }
    end
  end
end
