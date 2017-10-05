#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project
  include Logue::Loggable
  
  attr_reader :dir
  
  def initialize dir: nil, url: nil, cls: nil
    @dir = dir
    @url = url
    @cls = cls
    debug "dir: #{dir}"
    debug "url: #{url}"
    debug "cls: #{cls}"
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

  def run_command cmdcls, cmdargs, args
    debug "cmdargs: #{cmdargs}"
    stack "args: #{args}"
    cmdargs = cmdargs.merge args
    debug "cmdargs: #{cmdargs}"
    cmd = cmdcls.new cmdargs, cls: @cls
    debug "cmd: #{cmd}"
    cmd.respond_to?(:entries) ? cmd.entries : cmd.output
  end

  def self.add_command_delegator name, takes_multiple_paths
    require "svnx/#{name}/command"

    pathargs = (takes_multiple_paths ? "{ paths: [ @dir ], url: @url }" : "{ path: @dir, url: @url }")
    
    args = [
      "Svnx::#{name.to_s.capitalize}::Command",
      pathargs,
      "**args"
    ]

    src = [
      "def #{name} cls: nil, **args",
      "  run_command " + args.join(", ") + ", cls: @cls",
      "end"
    ].join("\n")

    # Logue::Log.debug "src: #{src}"
    module_eval src
  end

  add_command_delegator :info,    false
  
  add_command_delegator :update,  true
  add_command_delegator :merge,   true
  add_command_delegator :commit,  true
  add_command_delegator :log,     false
  
  add_command_delegator :diff,    false
  add_command_delegator :propset, false
  add_command_delegator :propget, false

  def to_s
    where.to_s
  end  
end
