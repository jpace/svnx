#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
end

module Svnx::ObjectUtil
  # shortcut for "@var = args[:var]", for multiple variable names, which are symbols.
  def assign args, *symbols
    symbols.each do |symbol|
      instance_variable_set "@" + symbol.to_s, args[symbol]
    end
  end
end
