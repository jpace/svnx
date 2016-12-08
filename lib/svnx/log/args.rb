#!/usr/bin/ruby -w
# -*- ruby -*-

require 'system/command/line'
require 'system/command/caching'
require 'svnx/base/command'
require 'logue/loggable'
require 'svnx/base/args'

module SvnLog
  class Args < SVNx::CommandArgs
    include Logue::Loggable
    
    attr_reader :limit
    attr_reader :verbose
    attr_reader :revision
    attr_reader :use_cache

    def initialize args
      @limit = args[:limit]
      @verbose = args[:verbose]
      @use_cache = args.key?(:use_cache) ? args[:use_cache] : false
      @revision = args[:revision]
      super
    end

    def to_a
      ary = Array.new
      if @limit
        ary << '--limit' << @limit
      end
      if @verbose
        ary << '-v'
      end

      if @revision
        [ @revision ].flatten.each do |rev|
          ary << "-r#{rev}"
        end
      end

      if @path
        ary << @path
      end
      
      ary.compact
    end
  end
end

# the old name and module
module SVNx
  module LogCmdLine
    class LogCommandArgs < SvnLog::Args
    end
  end
end
