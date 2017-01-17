#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'
require 'svnx/base/options'

module Svnx
  module Status
  end
end

class Svnx::Status::Options < Svnx::Base::Options
  attr_reader :revision
  attr_reader :url
  attr_reader :paths
  
  def initialize args
    assign args, :revision, :url, :paths
  end
  
  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :revision, [ "-r", @revision ] ]
      optargs << [ :url,      @url ]
      optargs << [ :paths,    @paths ]
    end
  end
end
