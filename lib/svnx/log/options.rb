#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Log
  end
end

class Svnx::Log::Options < Svnx::Base::Options
  attr_reader :limit
  attr_reader :verbose
  attr_reader :revision
  attr_reader :url
  attr_reader :path
  
  def initialize args
    assign args, :limit, :verbose, :revision, :url, :path
  end
  
  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :limit,    [ "--limit", limit ] ]
      optargs << [ :verbose,  "-v" ]
      optargs << [ :revision, "-r" + revision.to_s ]
      optargs << [ :url,      url ]
      optargs << [ :path,     path ]
    end
  end
end
