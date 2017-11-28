#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/blame/options'
require 'svnx/base/command'

module Svnx::Blame
  class Command < Svnx::Base::Command
    caching
  end
end
