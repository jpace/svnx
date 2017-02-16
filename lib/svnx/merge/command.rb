#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/base/command'

class Svnx::Merge::Command < Svnx::Base::Command
  noncaching
end
