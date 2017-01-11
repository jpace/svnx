#!/usr/bin/ruby -w
# -*- ruby -*-

class SvnMergeOptions
  attr_reader :commit
  attr_reader :range
  attr_reader :accept
  attr_reader :from
  attr_reader :path
  attr_reader :url
  
  def initialize args = Hash.new
    assign args, :url, :path, :accept, :range, :commit, :from
  end

  def assign args, *symbols
    symbols.each do |symbol|
      # @var = args[:var]
      code = "@" + symbol.to_s + " = args[:" + symbol.to_s + "]"
      instance_eval code
    end
  end
end
