#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/cat/options'
require 'svnx/base/command'

module Svnx::Cat
  class Command < Svnx::Base::Command
    caching
  end
end
