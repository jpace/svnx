#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'
require 'svnx/base/command'
require 'pp'

class Svnx::Status::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    true
  end

  def caching?
    false
  end
end

class Svnx::Status::Command < Svnx::Base::Command
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute

    cl = Svnx::Status::CommandLine.new nil, nil
    if cl.uses_xml? and not @output.empty? 
      @entries = Svnx::Status::Entries.new xmllines: @output
    end
  end
end
