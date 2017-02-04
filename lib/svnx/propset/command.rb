#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/command'

class Svnx::Propset::Command < Svnx::Base::Command
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: false, caching: false, options: cmdopts
  end
end
