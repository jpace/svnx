#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'

class Svnx::Status::Command < Svnx::Base::Command
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: true, caching: false, options: cmdopts    
    if not @output.empty? 
      @entries = Svnx::Status::Entries.new xmllines: @output
    end
  end
end
