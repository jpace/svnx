#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'logue/log'
require 'svnx/base/cmdline'
require 'svnx/mock'
require 'paramesan'

# no verbose if running all tests:
level = ARGV.size == 0 ? Logue::Level::DEBUG : Logue::Level::WARN

Logue::Log.level = level
Logue::Log.set_widths(-35, 4, -35)

module Svnx
  class TestCase < Test::Unit::TestCase
    include Logue::Loggable
    include Paramesan
  end
end
