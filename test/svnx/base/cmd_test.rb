#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'svnx/base/cmd'

module Svnx
  class CmdTest < Test::Unit::TestCase
    def test_init
      str = Array.new.tap do |a|
        a << '<?xml version="1.0" encoding="UTF-8"?>'
        a << '<properties>'
        a << '<target'
        a << '   path="/abc/def">'
        a << '<property'
        a << '   name="svn:ignore">.ghi'
        a << 'staging'
        a << '</property>'
        a << '</target>'
        a << '</properties>'
      end.join "\n"

      Cmd.new str
    end
  end
end
