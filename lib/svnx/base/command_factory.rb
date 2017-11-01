#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/util/classutil'

module Svnx::Base
  class CommandFactory
    include Logue::Loggable
    
    def create cmdcls, cmdlinecls: nil, optcls: nil
      melements = ClassUtil::Util.module_elements cmdcls
      
      optcls ||= begin
                   modl = ClassUtil::Util.find_module cmdcls
                   modl::Options
                 end

      cmdlinecls ||= CommandLine

      { options_class: optcls, subcommand: melements[-1].downcase, command_line_class: cmdlinecls }
    end
  end
end
