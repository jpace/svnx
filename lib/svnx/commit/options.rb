#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

class Svnx::Commit::Options < Svnx::Base::Options
  include Svnx::ObjectUtil

  attr_reader :file
  attr_reader :paths
  attr_reader :url
  
  def initialize args = Hash.new
    assign args, :file, :paths, :url
  end

  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :file,   [ "-F", file ] ]
      optargs << [ :url,    url ]
      optargs << [ :paths,  paths ]
    end
  end  
end
