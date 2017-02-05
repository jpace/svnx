#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/base/command'

class Svnx::Commit::Command < Svnx::Base::Command
  noncaching
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, options: cmdopts
  end
end
