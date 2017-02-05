#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

class Svnx::Info::Command < Svnx::Base::EntriesCommand
  caching
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, options: cmdopts
  end
end
