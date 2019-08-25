#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/status/options'
require 'svnx/status/entries'
require 'svnx/base/entries_command'

module Svnx::Status
  class Command < Svnx::Base::EntriesCommand
    noncaching
  end
end
