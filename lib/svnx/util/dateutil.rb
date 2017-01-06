#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'

class DateUtil
  class << self
    def relative_full datetime, reltime = Time.now
      secs = (reltime - datetime).to_i
      if ago = to_time_units(secs)
        ago + " ago (" + fmt_mmdd_hhmm(datetime) + ")"
      else
        datetime.strftime "%Y/%m/%d %H:%M"
      end
    end

    def to_time_units seconds
      secs = seconds.to_i

      if secs < 120
        "#{secs} seconds"
      elsif (min = secs / 60) < 120
        "#{min} minutes"
      elsif (hour = min / 60) < 72
        "#{hour} hours"
      elsif (day = hour / 24) < 7
        "#{day} days"
      end
    end

    def fmt_mmdd_hhmm date
      date.strftime "%m/%d %H:%M"
    end
  end
end
