#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/util/classutil'

module Svnx::Base
  class CommandParams
    attr_reader :options
    attr_reader :subcommand

    def initialize options: nil, subcommand: nil
      @options = options
      @subcommand = subcommand
    end
  end
  
  class CommandFactory
    include Logue::Loggable

    def initialize cmdlinefactory = CommandLineFactory.new
      @cmdlinefactory = cmdlinefactory
    end
    
    def create cmdcls, cmdlinecls: nil
      melements = ClassUtil.module_elements cmdcls
      
      optcls = begin
                 modl = ClassUtil.find_module cmdcls
                 modl::Options
               end
      
      CommandParams.new options: optcls, subcommand: melements[-1].downcase
    end

    def command_line_factory
      @cmdlinefactory
    end
  end
end
