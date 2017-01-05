#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'

class SvnDiffArgs
  def initialize options
    @options = options
  end

  def to_svn_args
    Array.new.tap do |args|
      add_if args, @options.commit, "-c", @options.commit
      add_if args, @options.ignoreproperties, "--ignore-properties"
      add_if args, @options.ignorewhitespace, "-x", "-bw"
    end
  end

  def add_if args, condition, *values
    if condition
      args.concat values
    end
  end
end
