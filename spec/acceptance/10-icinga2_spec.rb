require 'spec_helper_acceptance'

describe 'icinga2' do

  context 'with defaults' do
    it 'should idempotently run' do
      pp = <<-EOS
      class { '::icinga2': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe service('icinga2') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end

