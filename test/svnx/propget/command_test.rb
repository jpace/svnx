#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/command'
require 'svnx/command/tc'

module Svnx::Propget
  class CommandTest < Svnx::Command::TestCase
    def test_revision
      args = { revision: 123 }
      assert_command args
    end

    def test_xml
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal true, cmd.xml?
    end
    
    def test_caching
      cmd = Command.new Hash.new, cmdlinecls: Svnx::Base::MockCommandLine
      assert_equal false, cmd.caching?
    end
  end
end
