#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/log/entries'
require 'svnx/base/command'

class Svnx::Log::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    true
  end

  def caching?
    @caching ||= false
  end
end

class Svnx::Log::Command < Svnx::Base::Command
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute

    cl = Svnx::Log::CommandLine.new nil, nil
    if cl.uses_xml? and not @output.empty? 
      @entries = Svnx::Log::Entries.new xmllines: @output
    end
  end
end
