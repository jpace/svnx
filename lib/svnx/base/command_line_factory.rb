#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/base/command_factory'

module Svnx::Base
  class CommandLineFactory
    include Logue::Loggable
    
    def create params: nil, subcommand: nil, cls: nil, xml: nil, caching: nil, args: nil
      cls ||= CommandLine
      subcommand ||= params.subcommand
      cls.new subcommand: subcommand, xml: xml, caching: caching, args: args
    end
  end
end
