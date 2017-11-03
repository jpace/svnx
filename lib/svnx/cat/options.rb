#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Cat
  end
end

module Svnx::Cat
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :path, :url ]
    
    attr_readers FIELDS
    
    def initialize args
      assign args, FIELDS
    end

    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :url,      url ]
        a << [ :path,     path ]
      end
    end
  end
end
