#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/command'

class Svnx::Propset::Command < Svnx::Base::Command
  noncaching
end
