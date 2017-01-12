#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'

class Svnx::CommonArgsTestCase < Test::Unit::TestCase
  def assert_to_svn_args expected, optargs = Hash.new
    opts = create_options optargs
    create_args(opts).tap do |args|
      assert_equal expected, args.to_svn_args, "optargs: #{optargs}"
    end
  end  
end
