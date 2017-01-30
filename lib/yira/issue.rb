#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'

class Issue
  include ObjectUtil
  
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
