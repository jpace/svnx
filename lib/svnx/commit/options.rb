#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    FIELDS = [ :file, :paths ]

    has_fields FIELDS

    def options_to_args
      Array.new.tap do |a|
        a << [ :file,   [ "-F", file ] ]
        a << [ :paths,  paths ]
      end
    end  
  end
end
