#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/command'
require 'svnx/diff/parser'

module Svnx::Diff
  class Command < Svnx::Base::Command
    attr_reader :entries
    
    def initialize cmdopts, cmdlinecls: Svnx::Base::CommandLine
      super cmdopts, cmdlinecls: cmdlinecls, xml: false, caching: true
      if @output
        @entries = Svnx::Diff::Parser.new.parse_all_output @output.dup
      end
    end
  end
end
