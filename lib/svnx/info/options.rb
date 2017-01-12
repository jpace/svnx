#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

class SvnInfoOptions
  include Svnx::ObjectUtil
  
  attr_reader :revision
  attr_reader :url
  attr_reader :path
  
  def initialize args
    assign args, :revision, :url, :path
  end
end
