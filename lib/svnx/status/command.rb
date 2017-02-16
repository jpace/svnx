#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'

class Svnx::Status::Command < Svnx::Base::EntriesCommand
  noncaching
end
