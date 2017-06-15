#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  module Revision
  end
end

module Svnx::Revision
  class DateToDate
    attr_reader :from
    attr_reader :to
    
    def initialize from, to
      @from = from
      @to = to
    end

    def to_svn_str
      [ @from, @to ].collect { |dt| "{" + to_svn_date(dt) + "}" }.join(":")
    end
    
    def to_svn_date date
      date.strftime "%Y-%m-%d"
    end
  end
end
