#!/usr/bin/ruby -w
# -*- ruby -*-
  
require 'svnx/base/options'

module Svnx
  module Merge
  end
end

module Svnx::Merge
  class Options < Svnx::Base::Options
    attr_reader :commit
    attr_reader :range
    attr_reader :accept
    attr_reader :from
    attr_reader :path
    attr_reader :url
    
    def initialize args = Hash.new
      assign args, :url, :path, :accept, :range, :commit, :from
    end

    def options_to_args
      # an array, not a hash, because "from" should be in the exec args before "url"/"path"
      Array.new.tap do |optargs|
        optargs << [ :commit, [ "-c", commit ] ]
        optargs << [ :range,  [ "-r", range ] ]
        optargs << [ :accept, [ "--accept", accept ] ]
        optargs << [ :from,   from ]
        optargs << [ :url,    url ]
        optargs << [ :path,   path ]
      end
    end  
  end
end
