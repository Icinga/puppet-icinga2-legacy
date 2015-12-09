require 'spec_helper'

describe 'icinga2::pki::icinga' do

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        "class { 'icinga2': }"
      end

      let(:params) do
        {
          :ticket_salt    => '1234567890',
          :icinga_ca_host => 'myicinga.example.com',
        }
      end

      it { is_expected.to compile }
      it { should contain_class('icinga2::pki::icinga') }
      it { should contain_exec('icinga2 pki create key').with_command(/foo\.example\.com/) }
      it { should contain_file('/etc/icinga2/pki/foo.example.com.key') }
      it { should contain_file('/etc/icinga2/pki/foo.example.com.crt') }
      it { should contain_exec('icinga2 pki get trusted-cert').
        with_command(/myicinga\.example\.com/).
        with_command(/foo\.example\.com/)
      }
      it { should contain_file('/etc/icinga2/pki/trusted-cert.crt') }
      it { should contain_exec('icinga2 pki request').
          with_command(/myicinga\.example\.com/).
          with_command(/foo\.example\.com/).
          with_command(/--ticket '64b3519cd69134b9bb11c0dbc349fb0c666dee99'/)
      }
      it { should contain_file('/etc/icinga2/pki/ca.crt') }
      it { should contain_class('icinga2::feature::api') }

    end
  end
end
