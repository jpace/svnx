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

    attr_reader :file
    attr_reader :paths
    
    def initialize args = Hash.new
      assign args, :file, :paths
      check args,  :file, :paths
    end

    def check args, *symbols
      invalid = args.keys.reject do |field|
        symbols.include? field
      end

      unless invalid.empty?
        raise "invalid fields for #{self.class}: #{invalid.join(' ')}"
      end
    end

    def options_to_args
      Array.new.tap do |optargs|
        optargs << [ :file,   [ "-F", file ] ]
        optargs << [ :paths,  paths ]
      end
    end  
  end
end
