#!/usr/bin/ruby -w
# -*- ruby -*-

require 'tc'
require 'svnx/base/action'

class Svnx::ActionStatusTestCase < Svnx::TestCase
  include Logue::Loggable

  def assert_symbol_for expected, *args
    sas = Svnx::ActionStatus.instance
    args.each do |arg|
      sym = sas.symbol_for arg
      assert_equal expected, sym, "arg: #{arg}"
    end
  end    
  
  def test_added
    assert_symbol_for :added, 'A', :added, 'added'
  end
  
  def test_deleted
    assert_symbol_for :deleted, 'D', :deleted, 'deleted'
  end
  
  def test_modified
    assert_symbol_for :modified, 'M', :modified, 'modified'
  end
  
  def test_unversioned
    assert_symbol_for :unversioned, '?', :unversioned, 'unversioned'
  end
end

class Svnx::ActionTestCase < Svnx::TestCase
  def assert_action_equals expadd, expdel, expmod, expunver, val
    action = Svnx::Action.new val
    msg = "value: #{val}"
    
    assert_equal expadd,   action.added?,       msg
    assert_equal expdel,   action.deleted?,     msg
    assert_equal expmod,   action.modified?,    msg
    assert_equal expunver, action.unversioned?, msg
  end    
  
  def assert_actions_equals expadd, expdel, expmod, expunver, *vals
    vals.each do |val|
      assert_action_equals expadd, expdel, expmod, expunver, val
    end
  end
  
  def test_added
    assert_actions_equals true, false, false, false, 'added', 'A', :added
  end
  
  def test_deleted
    assert_actions_equals false, true, false, false, 'deleted', 'D', :deleted
  end
  
  def test_modified
    assert_actions_equals false, false, true, false, 'modified', 'M', :modified
  end    
  
  def test_unversioned
    assert_actions_equals false, false, false, true, 'unversioned', '?', :unversioned
  end

  def test_constants
    assert_equal Svnx::Action.new('added'), Svnx::Action::ADDED
    assert_equal Svnx::Action.new('deleted'), Svnx::Action::DELETED
    assert_equal Svnx::Action.new('modified'), Svnx::Action::MODIFIED
    assert_equal Svnx::Action.new('unversioned'), Svnx::Action::UNVERSIONED 
  end
  
  def test_invalid_type
    assert_raise(RuntimeError) do
      Svnx::Action.new('dummy')
    end
  end
end
