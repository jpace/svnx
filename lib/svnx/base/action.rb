#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'singleton'

module SVNx
end

class SvnActionStatus
  include Singleton

  attr_reader :stati

  def initialize 
    @status_to_symbol = Hash.new
    @stati = Array.new

    add_type 'added',       'A'
    add_type 'deleted',     'D'
    add_type 'modified',    'M'
    add_type 'unversioned', '?'
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

class SVNx::Action
  include Logue::Loggable, Comparable
  
  attr_reader :type
  
  def initialize type, char = nil
    if type.kind_of? self.class
      @type = type.type
    else
      sas = SvnActionStatus.instance
      unless @type = sas.symbol_for(type)
        raise "not a valid action type: #{type}"
      end
    end
  end

  def <=> other
    @type <=> other.type
  end

  def to_s
    @type.to_s
  end
  
  sas = SvnActionStatus.instance
  sas.stati.each do |str|
    action = SVNx::Action.new str
    SVNx::Action.const_set str.upcase, action
    
    methname = str + '?'
    define_method methname do
      instance_eval do
        sym = SvnActionStatus.instance.symbol_for str
        @type.to_sym == sym
      end
    end      
  end  
end
