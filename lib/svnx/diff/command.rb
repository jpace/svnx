#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/command'
require 'svnx/diff/parser'

module Svnx::Diff
  class Command < Svnx::Base::Command
    noncaching
    nonxml
    
    attr_reader :entries
    
    def initialize cmdopts, cmdlinecls: Svnx::Base::CommandLine
      super cmdopts, cmdlinecls: cmdlinecls, caching: true
      if @output
        debug "@output: #{@output}"
        debug "@entries: #{@entries}"
        @entries = Svnx::Diff::Parser.new.parse_all_output @output.dup
      else
        debug "Svnx::Diff::Command#init: no output"
      end
    end
  end
end
