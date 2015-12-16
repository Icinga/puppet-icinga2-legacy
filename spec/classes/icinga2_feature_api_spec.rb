require 'spec_helper'

describe 'icinga2::feature::api' do

  on_supported_os.each do |os, facts|

    let :facts do
      facts
    end

    context "on #{os} with default parameters" do
     let :pre_condition do
        "class { 'icinga2': }"
      end

      it { should contain_class('icinga2::feature::api') }
      it { should contain_icinga2__feature('api') }
      it { should contain_file('icinga2 feature api').
        with_content(/accept_commands = false/).
        with_content(/accept_config = false/).
        with_content(/ca_path = "\/etc\/icinga2\/pki/).
        with_content(/cert_path = "\/etc\/icinga2\/pki/).
        with_content(/key_path = "\/etc\/icinga2\/pki/).
        #with_content(/crl_path = "\/etc\/icinga2\/pki/).
        without_content(/bind_host/).
        without_content(/bind_port/)
      }
    end

    context "on #{os} with changed parameters" do
      let :pre_condition do
        "class { 'icinga2':
        }
        class { 'icinga2::feature::api':
          bind_host       => '1.1.1.1',
          bind_port       => 1234,
          accept_commands => true,
          accept_config   => true,
          ca_path         => '/pki/ca.pem',
          cert_path       => '/pki/cert.pem',
          key_path        => '/pki/key.pem',
          crl_path        => false,
        }"
      end

      it { should contain_class('icinga2::feature::api') }
      it { should contain_icinga2__feature('api') }
      it { should contain_file('icinga2 feature api').
        with_content(/accept_commands = true/).
        with_content(/accept_config = true/).
        with_content(/ca_path = "\/pki/).
        with_content(/cert_path = "\/pki/).
        with_content(/key_path = "\/pki/).
        with_content(/bind_host = "1.1.1.1"/).
        with_content(/bind_port = 1234/).
        without_content(/crl_path =/)
      }
    end

  end

end
