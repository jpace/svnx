#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

class SvnDiffOptions
  attr_reader :commit
  attr_reader :ignoreproperties
  attr_reader :ignorewhitespace
  
  def initialize args = Hash.new
    @commit = args[:commit]
    @ignoreproperties = args[:ignoreproperties]
    @ignorewhitespace = args[:ignorewhitespace]
  end
end
