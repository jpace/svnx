#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/action'
require 'svnx/tc'
require 'paramesan'

module Svnx
  class ActionTestCase < Svnx::TestCase
    include Paramesan

    def self.build_params
      Array.new.tap do |a|
        a << [ true,  false, false, false, 'added',       'A', :added       ]
        a << [ false, true,  false, false, 'deleted',     'D', :deleted     ]
        a << [ false, false, true,  false, 'modified',    'M', :modified    ]
        a << [ false, false, false, true,  'unversioned', '?', :unversioned ]
      end
    end

    def assert_action expadd, expdel, expmod, expunver, action, msg
      assert_equal expadd,   action.added?,       msg
      assert_equal expdel,   action.deleted?,     msg
      assert_equal expmod,   action.modified?,    msg
      assert_equal expunver, action.unversioned?, msg
    end

    param_test build_params do |expadd, expdel, expmod, expunver, str, char, sym|
      action = Svnx::Action.new str
      assert_action expadd, expdel, expmod, expunver, action, "str: #{str}"
    end

    param_test build_params do |expadd, expdel, expmod, expunver, str, char, sym|
      action = Svnx::Action.new char
      assert_action expadd, expdel, expmod, expunver, action, "char: #{char}"
    end

    param_test build_params do |expadd, expdel, expmod, expunver, str, char, sym|
      action = Svnx::Action.new sym
      assert_action expadd, expdel, expmod, expunver, action, "sym: #{sym}"
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
        Svnx::Action.new 'dummy'
      end
    end
  end
end
