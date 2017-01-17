#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propset
  end
end

class Svnx::Propset::Options < Svnx::Base::Options
  attr_reader :file
  attr_reader :revision
  attr_reader :revprop
  attr_reader :name
  attr_reader :value
  attr_reader :url
  attr_reader :path
  
  def initialize args
    assign args, :file, :revision, :revprop, :name, :value, :url, :path
  end

  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :file,     [ "--file", file ] ]
      optargs << [ :revision, [ "-r", revision ] ]
      optargs << [ :revprop,  "--revprop" ]
      optargs << [ :name,     name ]
      optargs << [ :value,    value ]
      optargs << [ :url,      url ]
      optargs << [ :path,     path ]
    end
  end
end
