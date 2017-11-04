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

    has_fields FIELDS

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
