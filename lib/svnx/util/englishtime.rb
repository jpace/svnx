#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'

class EnglishTime
  def relative_full datetime, reltime = Time.now
    secs = (reltime - datetime).to_i
    if ago = to_time_units(secs)
      ago + " ago (" + fmt_mmdd_hhmm(datetime) + ")"
    else
      fmt_yymmdd_hhmm datetime
    end
  end
  
  # returns the value in seconds, minutes, hours, or days, if within a week
  def to_time_units seconds
    secs = seconds.to_i

    max = Hash.new.tap do |h|
      h[:seconds] = 120
      h[:minutes] = 120
      h[:hours] = 72
      h[:days] = 7
    end

    interval = Hash.new.tap do |h|
      h[:seconds] = 60
      h[:minutes] = 60
      h[:hours] = 24
    end

    if secs < max[:seconds]
      "#{secs} seconds"
    elsif (min = secs / interval[:seconds]) < max[:minutes]
      "#{min} minutes"
    elsif (hour = min / interval[:minutes]) < max[:hours]
      "#{hour} hours"
    elsif (day = hour / interval[:hours]) < max[:days]
      "#{day} days"
    else
      nil
    end
  end

  def fmt_yymmdd_hhmm date
    date.strftime "%Y/%m/%d %H:%M"
  end

  def fmt_mmdd_hhmm date
    date.strftime "%m/%d %H:%M"
  end
end
