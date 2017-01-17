#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'logue/loggable'
require 'svnx/base/cmdline'
require 'svnx/base/command'
require 'svnx/diff/parser'

class Svnx::Diff::CommandLine < Svnx::CommandLine
  def uses_xml?
    false
  end

  def caching?
    true
  end

  def subcommand
    "diff"
  end
end

class Svnx::Diff::Command < Svnx::Base::Command
  include Logue::Loggable

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
