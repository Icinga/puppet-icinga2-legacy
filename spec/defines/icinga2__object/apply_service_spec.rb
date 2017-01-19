require 'spec_helper'
require 'variants'

describe 'icinga2::object::apply_service', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with basic parameters" do
      let :facts do
        facts
      end
      let :pre_condition do
        " include 'icinga2'"
      end

      let(:title) { 'check_http' }

      object_file = '/etc/icinga2/objects/applys/check_http.conf'
      it { should contain_icinga2__object__apply_service('check_http') }
      it { should contain_file(object_file).with({
                                                     :ensure => 'file',
                                                     :path => '/etc/icinga2/objects/applys/check_http.conf',
                                                     :content => /apply Service "check_http"/,
                                                 }) }
      it { should contain_file(object_file).with_content(/^\s*import "generic-service"$/) }
      it { should contain_file(object_file).with_content(/^\s*display_name = "check_http"$/) }

    end
    context "on #{name} with custom_prepend parameter" do
      let :facts do
        facts
      end
      let :params do
        {
            :custom_prepend =>  ['vars += config']
        }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'check_http' }

      object_file = '/etc/icinga2/objects/applys/check_http.conf'
      it { should contain_icinga2__object__apply_service('check_http') }
      it { should contain_file(object_file).with({
                                                     :ensure => 'file',
                                                     :path => '/etc/icinga2/objects/applys/check_http.conf',
                                                     :content => /apply Service "check_http"/,
                                                 }) }
      it { should contain_file(object_file).with_content(/^\s*import "generic-service"$/) }
      it { should contain_file(object_file).with_content(/^\s*display_name = "check_http"$/) }
      it { should contain_file(object_file).with_content(/^\s*vars \+= config/) }
    end
    context "on #{name} with custom_append parameter" do
      let :facts do
        facts
      end
      let :params do
        {
            :custom_append => ['if (host.vars.notification_type == "sms") {
         command = "sms-host-notification"
        } else {
         command = "mail-host-notification"
        }', 'vars += config']
        }
      end
      let :pre_condition do
        "include 'icinga2'"
      end

      let(:title) { 'check_http' }

      object_file = '/etc/icinga2/objects/applys/check_http.conf'
      it { should contain_icinga2__object__apply_service('check_http') }
      it { should contain_file(object_file).with({
                                                     :ensure => 'file',
                                                     :path => '/etc/icinga2/objects/applys/check_http.conf',
                                                     :content => /apply Service "check_http"/,
                                                 }) }
      it { should contain_file(object_file).with_content(/^\s*import "generic-service"$/) }
      it { should contain_file(object_file).with_content(/^\s*display_name = "check_http"$/) }
      it { should contain_file(object_file).with_content(/^\s*vars \+= config$/) }
      it { should contain_file(object_file).with_content(/^\s*if \(host.vars.notification_type == "sms"\) \{\n\s+command = "sms-host-notification"\n\s+\} else \{\n\s+command = "mail-host-notification"\n\s+\}$/) }
    end
  end
end
