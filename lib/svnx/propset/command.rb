#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/command'

class Svnx::Propset::Command < Svnx::Base::Command
  noncaching
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, options: cmdopts
  end
end
