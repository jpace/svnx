#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'
require 'svnx/info/entries'
require 'svnx/base/command'

module Svnx::Info
  class Command < Svnx::Base::EntriesCommand
    noncaching
  end
end
