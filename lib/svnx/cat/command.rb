#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/options'
require 'svnx/base/command'

class Svnx::Cat::Command < Svnx::Base::Command
  caching
end
