#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Options
    include Svnx::ObjectUtil

    def check args, valid = Array.new
      invalid = args.keys.reject do |field|
        valid.include? field
      end

      unless invalid.empty?
        raise "invalid fields for #{self.class}: #{invalid.join(' ')}"
      end
    end
    
    def to_args
      Array.new.tap do |args|
        options_to_args.each do |opt|
          optname = opt[0]
          values = opt[1]
          if send optname
            args.concat [ values ].flatten
          end
        end
      end
    end
  end
end
