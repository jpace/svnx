#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/commit/options'
require 'svnx/base/command'

module Svnx::Commit
  class Command < Svnx::Base::Command
    noncaching
  end
end
