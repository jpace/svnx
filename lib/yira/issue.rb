#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'
require 'time'
require 'logue/loggable'

class Issue
  include ObjectUtil, Logue::Loggable
  
  attr_reader :key

  def initialize json
    @key = json["key"]
  end

  def ymd str
    str && Time.parse(str).strftime("%Y-%m-%d")
  end

  def println field, value
    printf "%-12s: %s\n", field, value
  end
end
