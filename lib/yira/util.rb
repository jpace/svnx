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

module ObjectUtil
  def assign args, *symbols
    symbols.each do |symbol|
      # @var = args[:var]
      code = "@" + symbol.to_s + " = args[:" + symbol.to_s + "]"
      instance_eval code
    end
  end
end
