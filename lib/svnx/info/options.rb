#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Info
  end
end

class Svnx::Info::Options
  include Svnx::ObjectUtil
  
  attr_reader :revision
  attr_reader :url
  attr_reader :path
  
  def initialize args
    assign args, :revision, :url, :path
  end
end