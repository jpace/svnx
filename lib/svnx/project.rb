#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project  
  attr_reader :dir
  
  def initialize dir: nil, url: nil, cmdlinecls: nil
    @dir = dir
    @url = url
    @cmdlinecls = cmdlinecls
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

    modname  = Kernel.const_get "Svnx::" + cmd.to_s.capitalize    
    initargs = { url: "@url", path: "@dir", paths: "[ @dir ]" }
    optcls   = modname::Options
    opts     = optcls.new Hash.new
    fields   = opts.fields.keys
    params   = fields.collect { |key| key.to_s + ": " + (initargs[key] || "nil") }.join ", "
    cmdargs  = fields.collect { |key| key.to_s + ": " + key.to_s }.join ", "
    
    src = Array.new.tap do |a|
      a << "def #{cmd} #{params}, cmdlinecls: @cmdlinecls"
      a << "  svncmd = #{modname}::Command.new({ #{cmdargs} }, cmdlinecls: cmdlinecls)"
      a << "  svncmd.respond_to?(:entries) ? svncmd.entries : svncmd.output"
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

