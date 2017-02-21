#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/log/entries'
require 'svnx/revision/range'
require 'svnx/revision/argument'
require 'svnx/revision/argfactory'

module Svnx::Revision
  class RangeTestCase < Svnx::TestCase
    def setup
      xmllines = Resources::PT_LOG_R22_13_SECONDFILE_TXT.readlines
      @entries = Svnx::Log::Entries.new :xmllines => xmllines
    end

    def assert_range expstr, expfrom, expto, argfrom, argto = nil
      rg = Range.new argfrom, argto
      msg = "from: #{argfrom}; to: #{argto}"
      
      assert_equal expfrom, rg.from.to_s, msg
      assert_equal expto, rg.to.to_s, msg
      assert_equal expstr, rg.to_s, msg
      rg
    end

    def test_init
      assert_range '143:199', '143', '199', '143:199'
    end

    def test_to_working_copy
      rr = assert_range '143', '143', '', '143'
      assert rr.working_copy?
    end

    def test_init_takes_arguments
      fa = Argument.new 143
      ta = Argument.new 199
      assert_range '143:199', '143', '199', fa, ta
    end

    def test_to_head
      rr = assert_range '143:HEAD', '143', 'HEAD', '143', 'HEAD'
      assert rr.head?
    end
  end
end
