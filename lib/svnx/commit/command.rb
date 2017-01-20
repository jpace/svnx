#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/base/command'

class Svnx::Commit::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Commit::Command < Svnx::Base::Command
  include Logue::Loggable
  
  attr_reader :output

  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
