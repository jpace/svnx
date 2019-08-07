#!/usr/bin/ruby -w
# -*- ruby -*-

class StringUtil
  class << self
    def with_dashes x
      x.to_s.gsub "_", "-"
    end

    def with_underscores x
      x.to_s.gsub "-", "_"
    end
  end
end
