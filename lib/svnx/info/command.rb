#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

class Svnx::Info::Command < Svnx::Base::Command
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: true, caching: false, options: cmdopts
    unless @output.empty?
      @entries = Svnx::Info::Entries.new xmllines: @output
    end
  end
end
