#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/base/action'

module SVNx
  class ActionTestCase < SVNx::TestCase
    def assert_action_equals expadd, expdel, expmod, expunver, *vals
      vals.each do |val|
        action = Action.new val
        msg = "value: #{val}"
        assert_equal expadd, action.added?, msg
        assert_equal expdel, action.deleted?, msg
        assert_equal expmod, action.modified?, msg
        assert_equal expunver, action.unversioned?, msg
      end
    end    
    
    def test_added
      assert_action_equals true, false, false, false, 'added', 'A'
    end
    
    def test_deleted
      assert_action_equals false, true, false, false, 'deleted', 'D'
    end
    
    def test_modified
      assert_action_equals false, false, true, false, 'modified', 'M'
    end    
    
    def test_unversioned
      assert_action_equals false, false, false, true, 'unversioned', '?'
    end

    def test_constants
      assert_equal SVNx::Action.new('added'), SVNx::Action::ADDED
      assert_equal SVNx::Action.new('deleted'), SVNx::Action::DELETED
      assert_equal SVNx::Action.new('modified'), SVNx::Action::MODIFIED
      assert_equal SVNx::Action.new('unversioned'), SVNx::Action::UNVERSIONED 
    end
    
    def test_invalid_type
      assert_nil SVNx::Action.new('dummy')
    end
  end
end
