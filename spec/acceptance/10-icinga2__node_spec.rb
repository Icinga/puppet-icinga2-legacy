require 'spec_helper_acceptance'

describe 'icinga2::node' do

  context 'with defaults' do
    it 'should idempotently run' do
      pp = <<-EOS
      class { '::icinga2::node': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end

