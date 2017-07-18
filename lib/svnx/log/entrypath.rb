#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/action'

module Svnx
  module Log
  end
end

module Svnx::Log
  class EntryPath
    include Comparable
    
    attr_reader :kind, :action, :name
    
    def initialize args = Hash.new
      @kind = args[:kind]
      @action = args[:action]
      @name = args[:name]
    end

    def to_s
      @name
    end

    def <=> other
      name <=> other.name
    end

    def match? action, filter
      @action.to_s == action.to_s && @name.start_with?(filter)
    end
  end
end
