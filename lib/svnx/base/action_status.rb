#!/usr/bin/ruby -w
# -*- ruby -*-

require 'singleton'

module Svnx
  class ActionStatus
    include Singleton

    attr_reader :stati

    def initialize 
      @status_to_symbol = Hash.new
      @stati = Array.new

      add_type 'added',       'A'
      add_type 'deleted',     'D'
      add_type 'modified',    'M'
      add_type 'replaced',    'R'
      add_type 'unversioned', '?'
      add_type 'external',    'X'
      add_type 'normal',      'q' # actually, X, but in a different column than X for external
    end

    def symbol_for arg
      @status_to_symbol[arg]
    end

    def add_type str, char
      sym = str.to_sym
      @stati << str
      [ sym, str, char ].each do |key|
        @status_to_symbol[key] = sym
      end
    end  
  end
end
