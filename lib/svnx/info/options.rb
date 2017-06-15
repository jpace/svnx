#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'svnx/base/options'

module Svnx
  module Info
  end
end

module Svnx::Info
  class Options < Svnx::Base::Options
    attr_reader :revision
    attr_reader :url
    attr_reader :path
    
    def initialize args
      assign args, :revision, :url, :path
    end

    def options_to_args
      Array.new.tap do |optargs|
        optargs << [ :revision, [ "-r", revision ] ]
        optargs << [ :url,      url ]
        optargs << [ :path,     path ]
      end
    end
  end
end
