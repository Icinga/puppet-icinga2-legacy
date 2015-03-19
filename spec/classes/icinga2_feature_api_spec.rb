require 'spec_helper'
require 'variants'

describe 'icinga2::feature::api' do

  default = 'Debian wheezy'

  let :facts do
    IcingaPuppet.variants[default]
  end

  context "on #{default} with default parameters" do
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
      with_content(/crl_path = "\/etc\/icinga2\/pki/).
      without_content(/bind_host/).
      without_content(/bind_port/)
    }
    it { should contain_file('icinga2-pki-ca').with_source(/\.pem$/).without_content() }
    it { should contain_file('icinga2-pki-cert').with_source(/\.pem$/).without_content() }
    it { should contain_file('icinga2-pki-key').with_source(/\.pem$/).without_content() }
    it { should contain_file('icinga2-pki-crl').with_source(/\.pem$/).without_content() }
  end

  context "on #{default} with changed parameters" do
    let :pre_condition do
      "class { 'icinga2':
      }
      class { 'icinga2::feature::api':
        bind_host       => '1.1.1.1',
        bind_port       => 1234,
        accept_commands => true,
        accept_config   => true,
        ca_path         => '/pki/ca.pem',
        ca_source       => '/tmp/ca.pem',
        cert_path       => '/pki/cert.pem',
        cert_source     => '/tmp/cert.pem',
        key_path        => '/pki/key.pem',
        key_source      => '/tmp/key.pem',
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
    it { should contain_file('icinga2-pki-ca').with_source(/^\/tmp/) }
    it { should contain_file('icinga2-pki-cert').with_source(/^\/tmp/) }
    it { should contain_file('icinga2-pki-key').with_source(/^\/tmp/) }
    it { should_not contain_file('icinga2-pki-crl') }
  end

  context "on #{default} with pki not managed" do
    let :pre_condition do
      "class { 'icinga2':
      }
      class { 'icinga2::feature::api':
        manage_pki => false,
      }"
    end

    it { should_not contain_file('icinga2-pki-ca') }
    it { should_not contain_file('icinga2-pki-cert') }
    it { should_not contain_file('icinga2-pki-key') }
    it { should_not contain_file('icinga2-pki-crl') }
  end

end
