#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    FIELDS = [ :commit, :range, :accept, :from, :path, :url ]
    
    attr_readers FIELDS
    
    def initialize args = Hash.new
      assign args, FIELDS
    end

    def options_to_args
      # an array, not a hash, because "from" should be in the exec args before "url"/"path"
      Array.new.tap do |a|
        a << [ :commit, [ "-c", commit ] ]
        a << [ :range,  [ "-r", range ] ]
        a << [ :accept, [ "--accept", accept ] ]
        a << [ :from,   from ]
        a << [ :url,    url ]
        a << [ :path,   path ]
      end
    end  
  end
end
