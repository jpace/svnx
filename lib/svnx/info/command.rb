#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/base/cmdline'
require 'svnx/base/command'

class Svnx::Info::CommandLine < Svnx::CommandLine
  def uses_xml?
    true
  end
end

class Svnx::Info::Command < Svnx::Base::Command
  attr_reader :entry
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    info "@output: #{@output}"
    
    # info has only one entry
    unless @output.empty?
      entries = Svnx::Info::Entries.new xmllines: @output
      @entry = entries[0]
    end
  end
end
