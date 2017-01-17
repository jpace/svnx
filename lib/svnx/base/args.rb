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

# the new class:

module Svnx
  module Base
  end
end

# converts options to Svn command line arguments:
class Svnx::Base::Args
  include Logue::Loggable
  
  def initialize options
    @options = options
  end

  def to_svn_args
    Array.new.tap do |args|
      options_to_args.each do |opt|
        optname = opt[0]
        values = opt[1]
        if @options.send optname
          args.concat [ values ].flatten
        end
      end
    end
  end
end
