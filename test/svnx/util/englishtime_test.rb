#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/dateutil'
require 'svnx/tc'

class EnglishTimeTest < Svnx::TestCase
  def self.build_ago_params
    now = Time.now
    h1 = now - 3600
    s1 = "60 minutes ago (" + h1.strftime("%m/%d %H:%M") + ")"
    
    h3 = now - 3 * 3600
    s2 = "3 hours ago (" + h3.strftime("%m/%d %H:%M") + ")"

    Array.new.tap do |a|
      a << [ s1, h1, now ]
      a << [ s2, h3, now ]
    end
  end

  param_test build_ago_params do |expected, fromdate, todate|
    result = EnglishTime.new(fromdate).ago
    assert_equal expected, result
  end

  def self.build_earlier_params
    t1 = Time.new 2015, 11, 1, 12, 15, 0
    h1 = Time.new 2015, 11, 1, 11, 15, 0
    s1 = "60 minutes earlier (" + h1.strftime("%m/%d %H:%M") + ")"
    
    h2 = Time.new 2015, 11, 1, 9, 15, 0
    s2 = "3 hours earlier (" + h2.strftime("%m/%d %H:%M") + ")"
    
    h3 = Time.new 2014, 11, 1, 9, 15, 0
    s3 = h3.strftime "%Y/%m/%d %H:%M"

    Array.new.tap do |a|
      a << [ s1, h1, t1 ]
      a << [ s2, h2, t1 ]
      a << [ s3, h3, t1 ]
    end
  end

  param_test build_earlier_params do |expected, fromdate, todate|
    result = EnglishTime.new(fromdate).earlier todate
    assert_equal expected, result
  end

  def self.build_since_params
    word = "since"
    
    t1 = Time.new 2015, 11, 1, 12, 15, 0
    h1 = Time.new 2015, 11, 1, 11, 15, 0
    s1 = "60 minutes " + word + " (" + h1.strftime("%m/%d %H:%M") + ")"
    
    h2 = Time.new 2015, 11, 1, 9, 15, 0
    s2 = "3 hours " + word + " (" + h2.strftime("%m/%d %H:%M") + ")"
    
    h3 = Time.new 2014, 11, 1, 9, 15, 0
    s3 = h3.strftime "%Y/%m/%d %H:%M"

    Array.new.tap do |a|
      a << [ s1, h1, t1, word ]
      a << [ s2, h2, t1, word ]
      a << [ s3, h3, t1, word ]
    end
  end

  param_test build_since_params do |expected, fromtime, totime, word|
    result = EnglishTime.new(fromtime).since totime, word
    assert_equal expected, result
  end  
end
