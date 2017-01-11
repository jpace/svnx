#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

class SvnMergeOptions
  include Svnx::ObjectUtil
  
  attr_reader :commit
  attr_reader :range
  attr_reader :accept
  attr_reader :from
  attr_reader :path
  attr_reader :url
  
  def initialize args = Hash.new
    assign args, :url, :path, :accept, :range, :commit, :from
  end
end
