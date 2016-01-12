# Temporary due to https://github.com/rspec/rspec-expectations/issues/573
module Encoding; CompatibilityError = Class.new(StandardError); end if RUBY_VERSION < '1.9'

require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
include RspecPuppetFacts

RSpec.configure do |c|
  c.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
end

at_exit { RSpec::Puppet::Coverage.report! }
