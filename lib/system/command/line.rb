#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'open3'
require 'rainbow/ext/string'

module System
end

class System::CommandLine
  include Logue::Loggable

  attr_reader :args
  attr_reader :output
  attr_reader :error
  attr_reader :status

  def initialize args = Array.new
    @args = args.dup
  end

  def << arg
    @args << arg
  end

  def execute
    cmd = to_command
    debug "cmd: #{cmd}".color("8A8A43")
    
    Open3.popen3(cmd) do |stdin, stdout, stderr, wthr|
      @output = stdout.readlines
      @error = stderr.readlines
      @status = wthr.value
    end

    debug "@output: #{@output}"
    debug "@error: #{@error}"
    debug "@status: #{@status}"
    
    @output
  end

  def to_command
    @args.join ' '
  end
end
