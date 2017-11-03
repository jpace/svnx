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
    
    attr_readers FIELDS
    
    def initialize args
      assign args, FIELDS
    end
    
    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :url,      url ]
        a << [ :paths,    paths ]
      end
    end
  end
end
