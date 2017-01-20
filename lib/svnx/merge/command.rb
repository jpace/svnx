#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/base/command'

class Svnx::Merge::CommandLine < Svnx::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Merge::Command < Svnx::Base::Command
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
