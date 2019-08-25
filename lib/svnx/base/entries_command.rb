#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/classutil'
require 'svnx/base/command'

module Svnx::Base
  class EntriesCommand < Command
    attr_reader :entries
    
    def initialize options, cmdlinecls: nil, caching: caching?
      super options, cmdlinecls: cmdlinecls, caching: caching
      
      @entries = if not @output.empty?
                   entries_class = begin
                                     modl = ClassUtil.find_module self.class
                                     modl::Entries
                                   end
                   entries_class.new @output
                 end
    end

    def xml?
      true
    end
  end
end
