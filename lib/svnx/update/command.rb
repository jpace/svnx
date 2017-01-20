#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/cmdline'
require 'svnx/base/command'
require 'svnx/update/options'

module Svnx
  module Update
  end
end

class Svnx::Update::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    false
  end
end

class Svnx::Update::Command < Svnx::Base::Command
  
  attr_reader :output

  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
  end
end
