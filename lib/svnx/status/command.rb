#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'

class Svnx::Status::Command < Svnx::Base::EntriesCommand
  noncaching
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, options: cmdopts
  end
end
