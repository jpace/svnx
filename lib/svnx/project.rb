#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project  
  attr_reader :dir
  
  def initialize dir: nil, url: nil, cls: nil
    @dir = dir
    @url = url
    @cls = cls
  end

  def where
    @url || @dir
  end
  
  def url
    @url ||= begin
               entries = info
               entries && entries[0].url
             end
  end
  
  def path
    info.path
  end

  def self.add_delegator cmd
    require "svnx/#{cmd}/command"
    require "svnx/#{cmd}/options"

    initargs = Hash[url: "@url", path: "@dir", paths: "[ @dir ]"]
    optcls   = Kernel.const_get "Svnx::#{cmd.to_s.capitalize}::Options"
    opts     = optcls.new Hash.new
    fields   = opts.fields.keys
    params   = fields.collect { |key| key.to_s + ": " + (initargs[key] || "nil") }.join ", "
    cmdargs  = fields.collect { |key| key.to_s + ": " + key.to_s }.join ", "
    
    src = Array.new.tap do |a|
      a << "def #{cmd} #{params}, cls: @cls"
      a << "  cmd = Svnx::#{cmd.to_s.capitalize}::Command.new({ #{cmdargs} }, cls: cls)"
      a << "  cmd.respond_to?(:entries) ? cmd.entries : cmd.output"
      a << "end"
    end.join "\n"
    
    class_eval src
  end

  add_delegator :commit
  add_delegator :diff
  add_delegator :info
  add_delegator :log
  add_delegator :propget
  add_delegator :propset
  add_delegator :update

  def to_s
    where.to_s
  end  
end
