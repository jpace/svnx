#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

class Svnx::Propget::Options < Svnx::Base::Options
  attr_reader :revision
  attr_reader :revprop
  attr_reader :name
  attr_reader :url
  attr_reader :path
  
  def initialize args
    assign args, :revision, :revprop, :name, :url, :path
  end

  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :revision, [ "-r", revision ] ]
      optargs << [ :revprop,  "--revprop" ]
      optargs << [ :name,     name ]
      optargs << [ :url,      url ]
      optargs << [ :path,     path ]
    end
  end
end
