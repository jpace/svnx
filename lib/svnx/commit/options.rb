#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    include Svnx::ObjectUtil

    FIELDS = [ :file, :paths ]

    attr_readers FIELDS
    
    def initialize args = Hash.new
      assign args, FIELDS
      check args,  FIELDS
    end

    def check args, symbols = Array.new
      invalid = args.keys.reject do |field|
        symbols.include? field
      end

      unless invalid.empty?
        raise "invalid fields for #{self.class}: #{invalid.join(' ')}"
      end
    end

    def options_to_args
      Array.new.tap do |a|
        a << [ :file,   [ "-F", file ] ]
        a << [ :paths,  paths ]
      end
    end  
  end
end
