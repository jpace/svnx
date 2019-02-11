#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/action'
require 'svnx/tc'
require 'paramesan'

module Svnx
  class ActionTestCase < Svnx::TestCase
    include Paramesan

    def self.full_params
      Array.new.tap do |a|
        a << [ :added?,       'added',       'A', :added       ]
        a << [ :deleted?,     'deleted',     'D', :deleted     ]
        a << [ :modified?,    'modified',    'M', :modified    ]
        a << [ :replaced?,    'replaced',    'R', :replaced    ]
        a << [ :unversioned?, 'unversioned', '?', :unversioned ]
        a << [ :external?,    'external',    'X', :external    ]
        a << [ :normal?,      'normal',      'q', :normal      ]
      end
    end

    param_test full_params do |methname, str, abbrev, type|
      action = Svnx::Action.new type
      assert action.respond_to? methname, "type: #{type}"
    end

    param_test full_params do |methname, str, abbrev, type|
      action = Svnx::Action.new type
      methnames = self.class.full_params.collect { |x| x.first }
      methnames.reject { |mn| mn == methname }.each do |mn|
        assert_false action.send mn
      end
    end

    param_test full_params do |methname, str, abbrev, type|
      action = Svnx::Action.new type
      assert action.send methname
    end

    param_test [
      [ Svnx::Action.new('added'),       Svnx::Action::ADDED       ],
      [ Svnx::Action.new('deleted'),     Svnx::Action::DELETED     ],
      [ Svnx::Action.new('modified'),    Svnx::Action::MODIFIED    ],
      [ Svnx::Action.new('replaced'),    Svnx::Action::REPLACED    ],
      [ Svnx::Action.new('unversioned'), Svnx::Action::UNVERSIONED ],
      [ Svnx::Action.new('external'),    Svnx::Action::EXTERNAL    ],
      [ Svnx::Action.new('normal'),      Svnx::Action::NORMAL      ],
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
