require File.join(File.dirname(__FILE__), '../..', 'icinga2/utils.rb')

module Puppet::Parser::Functions
  newfunction(:icinga2_config_value, :type => :rvalue) do |args|
    raise Puppet::ParseError, 'Must provide exactly one argument to icinga2_config_value1' if args.length != 1

    Puppet::Icinga2::Utils.config_value(args[0])
  end
end
