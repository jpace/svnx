#!/usr/bin/ruby -w
# -*- ruby -*-

module CmdLine
end

class CmdLine::FileName
  attr_reader :name

  def initialize args
    @name = args.join('-').gsub('/', '_slash_') + '.gz'
  end

  def to_s
    @name
  end
end
