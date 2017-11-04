#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    # FIELDS = [ :commit, :range, :accept, :from, :path, :url ]
    FIELDS = [ :commit, :range, :accept, :from, :to ]
    
    has_fields FIELDS

    def options_to_args
      # an array, not a hash, because "from" should be in the exec args before "url"/"path"
      Array.new.tap do |a|
        a << [ :commit, [ "-c", commit ] ]
        a << [ :range,  [ "-r", range ] ]
        a << [ :accept, [ "--accept", accept ] ]
        a << [ :from,   from ]
        a << [ :to,   to ]
      end
    end  
  end
end
