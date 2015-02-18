require 'spec_helper_acceptance'

describe 'icinga2::server' do

  context 'with defaults' do
    it 'should idempotently run' do
      pp = <<-EOS
      class { '::icinga2::server':
        use_debmon_repo => true,
      }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end
