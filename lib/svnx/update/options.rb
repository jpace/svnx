#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Update
  end
end

class Svnx::Update::Options < Svnx::Base::Options
  attr_reader :revision
  attr_reader :paths
  
  def initialize args = Hash.new
    assign args, :revision, :paths
  end
  
  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :revision, [ "-r", revision ] ]
      optargs << [ :paths,    paths ]
    end
  end
end
