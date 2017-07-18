#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/tc'
require 'svnx/base/action'
require 'paramesan'

class Svnx::ActionStatusTestCase < Svnx::TestCase
  include Logue::Loggable
  include Paramesan

  param_test [
    [ :added,       [ 'A', :added,       'added'       ] ],
    [ :deleted,     [ 'D', :deleted,     'deleted'     ] ],
    [ :modified,    [ 'M', :modified,    'modified'    ] ],
    [ :unversioned, [ '?', :unversioned, 'unversioned' ] ],
  ] do |exp, args|
    sas = Svnx::ActionStatus.instance
    args.each do |arg|
      sym = sas.symbol_for arg
      assert_equal exp, sym, "arg: #{arg}"
    end
  end
end

class Svnx::ActionTestCase < Svnx::TestCase
  include Paramesan

  param_test [
    [ true,  false, false, false, 'added',       'A', :added       ],
    [ false, true,  false, false, 'deleted',     'D', :deleted     ],
    [ false, false, true,  false, 'modified',    'M', :modified    ],
    [ false, false, false, true,  'unversioned', '?', :unversioned ],
  ].each do |expadd, expdel, expmod, expunver, val|
    action = Svnx::Action.new val
    msg = "value: #{val}"
    
    assert_equal expadd,   action.added?,       msg
    assert_equal expdel,   action.deleted?,     msg
    assert_equal expmod,   action.modified?,    msg
    assert_equal expunver, action.unversioned?, msg
  end

  param_test [
    [ Svnx::Action.new('added'),       Svnx::Action::ADDED       ],
    [ Svnx::Action.new('deleted'),     Svnx::Action::DELETED     ],
    [ Svnx::Action.new('modified'),    Svnx::Action::MODIFIED    ],
    [ Svnx::Action.new('unversioned'), Svnx::Action::UNVERSIONED ],
  ].each do |exp, action|
    assert_equal exp, action
  end
  
  def test_invalid_type
    assert_raise(RuntimeError) do
      Svnx::Action.new('dummy')
    end
  end
end
