require 'puppet'

module Puppet
  module Icinga2
    module Utils

      def self.config_value(value, indent=2)
        indent += 2
        if value.is_a?(Hash)
          config_hash(value, indent)
        elsif value.is_a?(Array)
          config_array(value, indent)
        elsif value.is_a?(TrueClass) || value.is_a?(FalseClass)
          value
        else
          if value.class == String
            if value.match(/^\d+$/)
              return value.to_i
            elsif value.match(/^\d+\.\d+$/)
              return value.to_f
	    elsif value.match(/^%@@.*%@@$/)
	      return value.gsub(/%@@/, '')
            else
              # remove quotes from oldstyle values "something"
              value = value.gsub(/(^"|"$)/, '')
            end
          end
          value.to_s.dump
        end
      end

      def self.config_hash(hash, indent=2)
        txt = "{\n"
        hash.sort_by { |key, value| key }.each do |key, value|
          txt += "%s%s = %s\n" % [ ' ' * indent, config_value(key), config_value(value, indent) ]
        end
        txt += '%s}' % (' ' * (indent-2))
      end

      def self.config_array(array, indent=2)
        txt = "[\n"
        array.each do |value|
          txt += "%s%s,\n" % [ ' ' * indent, config_value(value, indent)]
        end
        txt += '%s]' % (' ' * (indent-2))
      end

    end
  end
end
