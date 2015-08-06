require 'spec_helper'
require 'variants'

describe 'icinga2::nrpe::command', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    context "on #{name} with default parameters" do
      let :facts do
        facts
      end

      let :pre_condition do
        "class {
          '::icinga2::nrpe':
        }"
      end

      let (:title) { '_COMMAND_' }
      let (:params) { { } }

      it { should compile }
      it { should_not contain_file("/etc/nagios/nrpe.d/_COMMAND_.cfg").with(
          'content' => /_COMMAND_/,
          'content' => /_PLUGIN_ARGS_/,
          'content' => /_PLUGIN_LIBDIR_/,
          'content' => /_PLUGIN_NAME_/,
        )
      }
    end

    context "on #{name} with parameter: nrpe_plugin_args" do
      let :facts do
        facts
      end

      let :pre_condition do
        "class {
          '::icinga2::nrpe':
        }"
      end

      let (:title) { '_COMMAND_' }

      let (:params) {
        {
          :nrpe_plugin_args => '_PLUGIN_ARGS_',
        }
      }

      it { should compile }
      it { should contain_file("/etc/nagios/nrpe.d/_COMMAND_.cfg").with(
          'content' => /_COMMAND_/,
          'content' => /_PLUGIN_ARGS_/,
        )
      }
    end

    context "on #{name} with parameter: nrpe_plugin_libdir" do
      let :facts do
        facts
      end

      let :pre_condition do
        "class {
          '::icinga2::nrpe':
        }"
      end

      let (:title) { '_COMMAND_' }

      let (:params) {
        {
          :nrpe_plugin_libdir => '_PLUGIN_LIBDIR_',
        }
      }

      it { should compile }
      it { should contain_file("/etc/nagios/nrpe.d/_COMMAND_.cfg").with(
          'content' => /_COMMAND_/,
          'content' => /_PLUGIN_LIBDIR_/,
        )
      }
    end

    context "on #{name} with parameter: nrpe_plugin_name" do
      let :facts do
        facts
      end

      let :pre_condition do
        "class {
          '::icinga2::nrpe':
        }"
      end

      let (:title) { '_COMMAND_' }

      let (:params) {
        {
          :nrpe_plugin_name => '_PLUGIN_NAME_',
        }
      }

      it { should compile }
      it { should contain_file("/etc/nagios/nrpe.d/_COMMAND_.cfg").with(
          'content' => /_COMMAND_/,
          'content' => /_PLUGIN_NAME_/,
        )
      }
    end
  end
end
