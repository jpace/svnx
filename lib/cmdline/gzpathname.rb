#!/usr/bin/ruby -w
# -*- ruby -*-

require 'zlib'
require 'pathname'

module CmdLine
  # A pathname that reads and writes itself as gzipped
  class GzipPathname < Pathname
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
end
