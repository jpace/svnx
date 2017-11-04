#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propset
  end
end

module Svnx::Propset
  class Options < Svnx::Base::Options
    FIELDS = [ :file, :revision, :name, :value, :url, :path ]
    
    has_fields FIELDS

    def options_to_args
      Array.new.tap do |a|
        a << [ :name,     name ]
        a << [ :revision, [ "--revprop", "-r", revision ] ]
        a << [ :file,     [ "--file", file ] ]
        a << [ :value,    value ]
        a << [ :url,      url ]
        a << [ :path,     path ]
      end
    end
  end
end
