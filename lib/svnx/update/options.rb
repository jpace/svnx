#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Update
  end
end

module Svnx::Update
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :paths ]
    
    attr_readers FIELDS
    
    def initialize args = Hash.new
      assign args, FIELDS
    end
    
    def options_to_args
      Array.new.tap do |a|
        a << [ :revision, [ "-r", revision ] ]
        a << [ :paths,    paths ]
      end
    end
  end
end
