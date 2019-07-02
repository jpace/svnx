#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/add/options'
require 'svnx/base/command'

module Svnx::Add
  class Command < Svnx::Base::Command
    noncaching
  end
end
