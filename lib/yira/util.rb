#!/usr/bin/ruby -w
# -*- ruby -*-

module StringUtil
  def brace
    "{" + self + "}"
  end

  def bracket
    "[" + self + "]"
  end

  def q
    "'" + self + "'"
  end

  def qq
    '"' + self + '"'
  end
end
