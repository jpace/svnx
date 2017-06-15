#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propset/options'
require 'svnx/base/command'

module Svnx::Propset
  class Command < Svnx::Base::Command
    noncaching
  end
end
