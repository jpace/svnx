#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

class SvnPropsetOptions
  include Svnx::ObjectUtil
  
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
end
