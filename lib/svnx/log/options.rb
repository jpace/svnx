#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Options < Svnx::Base::Options
    FIELDS = [ :limit, :verbose, :revision, :url, :path ]

    attr_readers FIELDS
    
    def initialize args
      assign args, FIELDS
    end
    
    def options_to_args
      Array.new.tap do |a|
        a << [ :limit,    [ "--limit", limit ] ]
        a << [ :verbose,  "-v" ]
        a << [ :revision, "-r" + revision.to_s ]
        a << [ :url,      url ]
        a << [ :path,     path ]
      end
    end
  end
end
