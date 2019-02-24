#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'
require 'svnx/util/englishtime'

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

    # returns the value in seconds, minutes, hours, or days, if within a week
    def to_time_units seconds
      EnglishTime.new.to_time_units seconds
    end

    def fmt_mmdd_hhmm date
      date.strftime "%m/%d %H:%M"
    end
  end
end
