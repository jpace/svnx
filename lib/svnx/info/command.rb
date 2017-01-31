#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

class Svnx::Info::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    true
  end
end

class Svnx::Info::Command < Svnx::Base::Command
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    info "@output: #{@output}"
    
    unless @output.empty?
      @entries = Svnx::Info::Entries.new xmllines: @output
    end
  end
end
