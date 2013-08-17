#!/usr/bin/ruby -w
# -*- ruby -*-

require 'integration/tc'
require 'svnx/info/command'
require 'svnx/info/entry'

module SVNx::Info
  class CommandTestCase < SVNx::IntegrationTestCase
    def test_specified_args
      entry = SVNx::InfoExec.new(path: '/Programs/pvn/pvntestbed.from', revision: nil, limit: nil, verbose: true, use_cache: false).entry
      
      assert_not_nil entry
      assert_equal 'dir', entry.kind
      assert_equal '/Programs/pvn/pvntestbed.from', entry.path
      assert_equal '22', entry.revision
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from', entry.root
      assert_equal 'file:///Programs/Subversion/Repositories/pvntestbed.from', entry.url
    end
  end
end
