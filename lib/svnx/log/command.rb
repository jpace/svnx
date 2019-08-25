#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/log/entries'
require 'svnx/base/entries_command'

module Svnx::Log
  class Command < Svnx::Base::EntriesCommand
    noncaching
  end
end
