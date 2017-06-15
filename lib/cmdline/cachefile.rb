#!/usr/bin/ruby -w
# -*- ruby -*-

require 'cmdline/line'
require 'zlib'
require 'logue/loggable'

module CmdLine
  class GzipPathname < Pathname
    include Logue::Loggable
    
    def save_file content
      parent.mkpath unless parent.exist?
      unlink if exist?
      Zlib::GzipWriter.open(to_s) do |gz|
        gz.puts content
      end
    end

    def read_file
      Array.new.tap do |content|
        Zlib::GzipReader.open(to_s) do |gz|
          content.concat gz.readlines
        end
      end
    end
  end

  class CacheFile
    include Logue::Loggable

    attr_reader :output
    attr_reader :pathname
    
    def initialize cache_dir, args
      @args = args
      basename = args.join('-').gsub('/', '_slash_') + '.gz'
      fullname = Pathname(cache_dir) + basename
      @pathname = GzipPathname.new fullname
      @output = nil
    end
    
    def readlines
      if @pathname.exist?
        @output = @pathname.read_file
      else
        cl = CommandLine.new @args
        @output = cl.execute
        @pathname.save_file @output
        @output
      end
    end

    def to_s
      @pathname.to_s
    end
  end
end