#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    attr_reader :commit
    attr_reader :ignoreproperties
    attr_reader :ignorewhitespace
    attr_reader :paths
    attr_reader :url
    
    def initialize args = Hash.new
      @commit = args[:commit]
      @ignoreproperties = args[:ignoreproperties]
      @ignorewhitespace = args[:ignorewhitespace]
      @paths = args[:paths]
      @url = args[:url]
    end

    def options_to_args
      Array.new.tap do |optargs|
        optargs << [ :commit, [ "-c", commit ] ]
        optargs << [ :ignoreproperties, "--ignore-properties" ] 
        optargs << [ :ignorewhitespace, [ "-x", "-bw" ] ]
        optargs << [ :url, url ]
        optargs << [ :paths, paths ]
      end
    end
  end
end
