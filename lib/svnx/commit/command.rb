#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/base/command'

class Svnx::Commit::Command < Svnx::Base::Command
  noncaching
end
