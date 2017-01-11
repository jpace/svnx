#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
end

module Svnx::ObjectUtil
  def assign args, *symbols
    symbols.each do |symbol|
      # @var = args[:var]
      code = "@" + symbol.to_s + " = args[:" + symbol.to_s + "]"
      instance_eval code
    end
  end
end
