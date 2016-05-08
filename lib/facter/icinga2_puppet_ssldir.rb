require 'facter'

# Based on the facter from https://github.com/jhg03a/puppet-agentfacts

# Set the preferred run mode.  This dictates what config sections get loaded.
# This fixes the issue where you are getting agentfacts from a manual facter -p run
# and the environment setting is wrong.
Puppet.settings.preferred_run_mode= :agent

# Pull in puppet settings from global variable
settings = Puppet.settings.to_h

# Resolve setting values to their bare value instead of the puppet setting class
pretty_settings = {}
settings.each do |key, value|
  if key.to_s == "ssldir"
    Facter.add("icinga2_puppet_ssldir") do 
      setcode do
        result = value.value
      end
    end
  end
end
