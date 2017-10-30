#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/action'
require 'svnx/tc'
require 'paramesan'

module Svnx
  class ActionStatusTestCase < Svnx::TestCase
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
end
