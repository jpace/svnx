#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/options'
require 'svnx/base/command'

module Svnx::Blame
  class Command < Svnx::Base::EntriesCommand
    caching
  end
end
