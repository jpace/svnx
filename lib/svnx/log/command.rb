#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/log/entries'
require 'svnx/base/command'

class Svnx::Log::Command < Svnx::Base::Command
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: true, caching: false, options: cmdopts
    if not @output.empty? 
      @entries = Svnx::Log::Entries.new xmllines: @output
    end
  end
end
