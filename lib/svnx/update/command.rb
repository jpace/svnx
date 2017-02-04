#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/update/options'

class Svnx::Update::Command < Svnx::Base::Command
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: false, caching: false, options: cmdopts
  end
end
