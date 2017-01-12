#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

# this replaces svnx/lib/command/svncommand.

module Svnx
end

class Svnx::CommandArgs
  include Logue::Loggable
  
  attr_accessor :path

  def initialize args = Hash.new
    @path = args[:path]
  end

  def to_a
    [ @path ].compact
  end
end  
