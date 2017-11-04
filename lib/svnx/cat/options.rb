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
    
    has_fields FIELDS

    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :url,      url ]
        a << [ :path,     path ]
      end
    end
  end
end
