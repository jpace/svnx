#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'

class TimeUtil
  attr_reader :intervals

  def initialize 
    @intervals = Hash.new.tap do |h|
      h[:seconds] = 60
      h[:minutes] = 60
      h[:hours] = 24
      h[:days] = 7
    end
  end
  
  # returns the value in seconds, minutes, hours, days, etc.
  def to_units seconds
    secs = seconds.to_i

    max = Hash.new.tap do |h|
      h[:seconds] = 120
      h[:minutes] = 120
      h[:hours] = 72
      h[:days] = 18
      h[:weeks] = 4
    end

    num = secs
    max.each do |field, value|
      if num < value
        return [ num, field ]
      elsif ival = @intervals[field]
        num /= ival
      end
    end
    nil
  end
end
