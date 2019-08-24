#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'svnx/base/command_factory'

module Svnx::Base
  class CommandLineFactory
    include Logue::Loggable
    
    def create params: nil, cls: nil, xml: nil, caching: nil, args: nil
      cls ||= params.cls
      cls.new subcommand: params.subcommand, xml: xml, caching: caching, args: args
    end
  end
end
