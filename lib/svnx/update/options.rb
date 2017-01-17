#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Update
  end
end

class Svnx::Update::Options
  include Svnx::ObjectUtil

  attr_reader :revision
  attr_reader :paths
  attr_reader :url
  
  def initialize args = Hash.new
    assign args, :revision, :paths, :url
  end
end
