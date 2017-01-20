#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

class Svnx::Info::CommandLine < Svnx::CommandLine
  def uses_xml?
    true
  end
end

class Svnx::Info::Command < Svnx::Base::Command
  attr_reader :output
  attr_reader :entry
  
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
