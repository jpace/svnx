#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'
require 'svnx/util/timeutil'

class EnglishTime
  attr_reader :time
  
  def initialize time
    @time = time
  end
  
  def ago
    since Time.new, "ago"
  end
  
  def earlier totime
    since totime, "earlier"
  end
  
  def since totime, name
    diff = totime - @time
    seconds = diff.to_i
    if units = TimeUtil.new.to_units(seconds)
      sprintf "%s %s %s (%s)", units.first, units.last, name, @time.strftime("%m/%d %H:%M")
    else
      @time.strftime "%Y/%m/%d %H:%M"
    end
  end
end
