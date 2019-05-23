#!/usr/bin/ruby -w
# -*- ruby -*-

require 'time'
require 'svnx/util/englishtime'

class DateUtil
  class << self
    def relative_full datetime, reltime = nil
      et = EnglishTime.new datetime
      if reltime
        et.since reltime, "earlier"
      else
        et.ago
      end
    end

    def fmt_mmdd_hhmm date
      date.strftime "%m/%d %H:%M"
    end
  end
end
