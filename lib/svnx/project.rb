#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
end

# A low-level wrapper around the Svnx commands, converting arguments (svnx/<command>/options) into
# entries (svnx/<command>/entry) or output. Enhances the low level functionality.

class Svnx::Project
  attr_reader :dir
  
  def initialize dir: nil, url: nil, exec: nil
    @dir = dir
    @url = url
    @exec = exec
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

  def run_command cmdcls, cmdargs, args, exec: nil
    cmdargs = cmdargs.merge args
    cmd = cmdcls.new cmdargs, exec: exec
    cmd.respond_to?(:entries) ? cmd.entries : cmd.output
  end

  def self.add_command_delegator name, takes_multiple_paths
    require "svnx/#{name}/command"

    pathargs = (takes_multiple_paths ? "{ paths: [ @dir ], url: @url }" : "{ path: @dir, url: @url }")
    
    args = [
      "Svnx::#{name.to_s.capitalize}::Command",
      pathargs,
      "args",
      "exec: exec"
    ]
    
    src = [
      "def #{name} exec: @exec, **args",
      "  run_command " + args.join(", "),
      "end"
    ].join("\n")
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
