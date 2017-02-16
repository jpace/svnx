#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/log/entries'
require 'svnx/base/command'

class Svnx::Log::Command < Svnx::Base::EntriesCommand
  noncaching
end
