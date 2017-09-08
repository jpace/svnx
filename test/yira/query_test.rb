#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require 'paramesan'
require 'yira/query'
require 'yira/fetcher/options'

class Yira::QueryTest < Test::Unit::TestCase
  def test_init
    opts = Yira::Fetcher::Options.new Array.new
    q = Yira::Query.new opts
    puts "q: #{q}"
  end
end
