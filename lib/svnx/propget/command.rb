#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/base/command'

class Svnx::Propget::Command < Svnx::Base::EntriesCommand
  noncaching
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, options: cmdopts
  end
end
