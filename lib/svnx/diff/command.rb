#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/cmdline'
require 'svnx/base/command'
require 'svnx/diff/parser'

class Svnx::Diff::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    false
  end

  def caching?
    true
  end
end

class Svnx::Diff::Command < Svnx::Base::Command
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    debug "output: #{@output}"
    if @output
      @entries = Svnx::Diff::Parser.new.parse_all_output @output
    end
  end
end
