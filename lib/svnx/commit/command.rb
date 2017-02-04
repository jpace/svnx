#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/base/command'

class Svnx::Commit::Command < Svnx::Base::Command
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: false, caching: false, options: cmdopts
  end
end
