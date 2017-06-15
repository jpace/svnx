#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/base/command'

module Svnx::Merge
  class Command < Svnx::Base::Command
    noncaching
  end
end
