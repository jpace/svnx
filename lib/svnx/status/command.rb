#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/status/options'
require 'svnx/status/entries'

module Svnx::Status
  class Command < Svnx::Base::EntriesCommand
    noncaching
  end
end
