#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :url, :paths ]
    
    has_fields FIELDS
    
    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :url,      url ]
        a << [ :paths,    paths ]
      end
    end
  end
end
