#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/command'
require 'svnx/diff/parser'

class Svnx::Diff::Command < Svnx::Base::Command
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: false, caching: true, options: cmdopts
    if @output
      @entries = Svnx::Diff::Parser.new.parse_all_output @output.dup
    end
  end
end
