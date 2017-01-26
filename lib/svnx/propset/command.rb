#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/cmdline'
require 'svnx/base/command'

class Svnx::Propset::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Propset::Command < Svnx::Base::Command
  include Logue::Loggable
  
  attr_reader :output
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
