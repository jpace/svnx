#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'singleton'

module Svnx
end

class Svnx::ActionStatus
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

class Svnx::Action
  include Logue::Loggable, Comparable
  
  attr_reader :type
  
  def initialize type, char = nil
    sas = Svnx::ActionStatus.instance
    unless @type = sas.symbol_for(type)
      raise "not a valid action type: #{type}"
    end
  end

  def <=> other
    @type <=> other.type
  end

  def to_s
    @type.to_s
  end
  
  sas = Svnx::ActionStatus.instance
  sas.stati.each do |str|
    action = Svnx::Action.new str
    Svnx::Action.const_set str.upcase, action
    
    methname = str + '?'
    define_method methname do
      instance_eval do
        sym = Svnx::ActionStatus.instance.symbol_for str
        @type.to_sym == sym
      end
    end      
  end  
end
