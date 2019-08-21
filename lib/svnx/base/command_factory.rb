#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/util/classutil'

module Svnx::Base
  class CommandParams
    attr_reader :options
    attr_reader :subcommand
    attr_reader :cmdline

    def initialize options: nil, subcommand: nil, cmdline: nil
      @options = options
      @subcommand = subcommand
      @cmdline = cmdline
    end
  end
  
  class CommandFactory
    include Logue::Loggable
    
    def create cmdcls, cmdlinecls: nil, optcls: nil
      melements = ClassUtil.module_elements cmdcls
      
      optcls ||= begin
                   modl = ClassUtil.find_module cmdcls
                   modl::Options
                 end

      cmdlinecls ||= CommandLine

      CommandParams.new options: optcls, subcommand: melements[-1].downcase, cmdline: cmdlinecls 
    end
  end
end
