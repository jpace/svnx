#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :paths, :urls ]
    
    has_fields FIELDS

    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :urls,     urls ]
        a << [ :paths,    paths ]
      end
    end
  end
end
