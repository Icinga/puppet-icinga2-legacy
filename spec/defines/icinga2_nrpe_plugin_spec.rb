require 'spec_helper'
require 'variants'

describe 'icinga2::nrpe::plugin', :type => :define do
  IcingaPuppet.variants.each do |name, facts|
    let (:mandatory_params) {
      {
        :nrpe_plugin_libdir => '/libdir'
      }
    }

    context "on #{name} with parameter: plugin_name" do
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
        mandatory_params.merge({
          :plugin_name => '_PLUGIN_NAME_',
        })
      }

      it { should compile }
      it { should contain_file("/libdir/_PLUGIN_NAME_").with(
          'mode' => '0755',
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
        mandatory_params.merge({
          :nrpe_plugin_libdir => '/custom/lib/dir',
        })
      }

      it { should compile }
      it { should contain_file("/custom/lib/dir/_COMMAND_").with(
          'mode' => '0755',
        )
      }
    end

    context "on #{name} with parameter: source_file" do
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
        mandatory_params.merge({
          :source_file => '/source/file',
        })
      }

      it { should compile }
      it { should contain_file("/libdir/_COMMAND_").with(
          'source' => '/source/file',
        )
      }
    end
  end
end
