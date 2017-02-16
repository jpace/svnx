#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/update/options'

class Svnx::Update::Command < Svnx::Base::Command
  noncaching
end
