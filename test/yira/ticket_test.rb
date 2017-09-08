#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'paramesan'
require 'yira/ticket'

class Yira::TicketFactoryTest < Test::Unit::TestCase
  include Paramesan

  param_test [
    [ Fix,    "Fix"    ],
    [ Issue,  "Issue"  ],
    [ Defect, "Defect" ],
  ] do |cls, type|
    tf = Yira::TicketFactory.new
    assert_equal cls, tf.issue_type_to_class(type)
  end
end
