#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'logue/loggable'
require 'system/command/caching'

# this replaces svnx/lib/command/svncommand.

module SVNx
  class CommandArgs
    include Logue::Loggable
    
    attr_accessor :path

    def initialize args = Hash.new
      @path = args[:path]
    end

    def to_a
      [ @path ].compact
    end
  end  
end
