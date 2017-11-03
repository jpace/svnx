#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    FIELDS = [ :commit, :ignoreproperties, :ignorewhitespace, :paths, :url, :depth ]
    
    attr_readers FIELDS
    
    def initialize args = Hash.new
      assign args, FIELDS
    end

    def options_to_args
      Array.new.tap do |a|
        a << [ :commit, [ "-c", commit ] ]
        a << [ :ignoreproperties, "--ignore-properties" ] 
        a << [ :depth, [ "--depth", depth ] ] 
        a << [ :ignorewhitespace, [ "-x", "-bw" ] ]
        a << [ :url, url ]
        a << [ :paths, paths ]
      end
    end
  end
end
