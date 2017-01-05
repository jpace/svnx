#!/usr/bin/ruby -w
# -*- ruby -*-

class SvnDiffOptions
  attr_reader :commit
  attr_reader :ignoreproperties
  attr_reader :ignorewhitespace
  attr_reader :path
  attr_reader :url
  
  def initialize args = Hash.new
    @commit = args[:commit]
    @ignoreproperties = args[:ignoreproperties]
    @ignorewhitespace = args[:ignorewhitespace]
    @path = args[:path]
    @url = args[:url]
  end
end
