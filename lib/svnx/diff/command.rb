#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'
require 'svnx/base/command'
require 'svnx/diff/parser'

module Svnx::Diff
  class Command < Svnx::Base::Command
    attr_reader :entries
    
    def initialize cmdopts, cls: Svnx::Base::CommandLine, exec: nil
      super cmdopts, cls: cls, exec: exec, xml: false, caching: true
      if @output
        @entries = Svnx::Diff::Parser.new.parse_all_output @output.dup
      end
    end
  end
end
