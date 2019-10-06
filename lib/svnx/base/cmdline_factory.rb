#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'

module Svnx::Base
  class CommandLineFactory
    def create subcommand: nil, cls: nil, xml: nil, caching: nil, args: nil
      cls ||= CommandLine
      cls.new subcommand: subcommand, xml: xml, caching: caching, args: args
    end
  end
end
