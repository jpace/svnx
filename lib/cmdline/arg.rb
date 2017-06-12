#!/usr/bin/ruby -w
# -*- ruby -*-

module CmdLine
end

class CmdLine::Argument < String
  # just a string, but quotes itself

  def to_s
    '"' + super + '"'
  end
end
