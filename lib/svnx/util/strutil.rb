#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  class StringUtil
    class << self
      def with_dashes x
        x.to_s.gsub "_", "-"
      end

      def with_underscores x
        x.to_s.gsub "-", "_"
      end
    end

    def to_boolean
      downcase == "true"
    end
  end
end
