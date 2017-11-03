#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :revprop, :name, :url, :path ]

    attr_readers FIELDS
    
    def initialize args
      assign args, FIELDS
    end

    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :revprop,  "--revprop" ]
        a << [ :name,     name ]
        a << [ :url,      url ]
        a << [ :path,     path ]
      end
    end
  end
end
