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

module HashUtil
  def join kstr, vstr
    keys.collect do |key|
      key.to_s + kstr + self[key].to_s
    end.join vstr
  end

  def compact
    Hash.new.tap do |hsh|
      keys.each do |key|
        if key && self[key]
          hsh[key] = self[key]
        end
      end
    end
  end
end

class String
  include StringUtil
end

class Object
  include ObjectUtil
end

class Hash
  include HashUtil
end
