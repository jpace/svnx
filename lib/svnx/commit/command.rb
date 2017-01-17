#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/args'
require 'svnx/base/cmdline'
require 'svnx/base/command'

module Svnx
  module Commit
  end
end

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
