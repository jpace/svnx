#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

class SvnDiffArgs
  def initialize args = Hash.new
    @commit = args[:commit]
    @ignoreproperties = args[:ignoreproperties]
    @ignorewhitespace = args[:ignorewhitespace]
  end

  def to_svn_args
    Array.new.tap do |args|
      add_if args, @commit, "-c", @commit
      add_if args, @ignoreproperties, "--ignore-properties"
      add_if args, @ignorewhitespace, "-x", "-bw"
    end
  end

  def add_if args, condition, *values
    if condition
      args.concat values
    end
  end
end
