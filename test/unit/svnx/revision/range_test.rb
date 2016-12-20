#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/log/entries'
require 'svnx/revision/range'
require 'svnx/revision/argument'
require 'svnx/revision/argfactory'
require 'resources'

module SVNx::Revision
  class RangeTestCase < SVNx::TestCase
    def setup
      xmllines = Resources::PT_LOG_R22_13_SECONDFILE_TXT.readlines
      @entries = SVNx::Log::Entries.new :xmllines => xmllines
    end

    def assert_range expstr, expfrom, expto, argfrom, argto = nil
      rg = Range.new argfrom, argto
      info "rg: #{rg}"
      msg = "from: #{argfrom}; to: #{argto}"
      info "msg: #{msg}"
      
      assert_equal expfrom, rg.from.to_s, msg
      assert_equal expto, rg.to.to_s, msg
      assert_equal expstr, rg.to_s, msg
      rg
    end

    def test_init
      info "self: #{self}"
      assert_range '143:199', '143', '199', '143:199'
    end

    def test_to_working_copy
      info "self: #{self}"
      rr = assert_range '143', '143', '', '143'
      assert rr.working_copy?
    end

    def test_init_takes_arguments
      info "self: #{self}"
      fa = Argument.new 143
      ta = Argument.new 199
      assert_range '143:199', '143', '199', fa, ta
    end

    def test_to_head
      info "self: #{self}"
      rr = assert_range '143:HEAD', '143', 'HEAD', '143', 'HEAD'
      assert rr.head?
    end
  end
end
