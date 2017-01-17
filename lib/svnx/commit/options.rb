#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Commit
  end
end

class Svnx::Commit::Options
  include Svnx::ObjectUtil

  attr_reader :file
  attr_reader :paths
  attr_reader :url
  
  def initialize args = Hash.new
    assign args, :file, :paths, :url
  end
end
