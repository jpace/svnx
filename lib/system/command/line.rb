#!/usr/bin/ruby -w
# -*- ruby -*-

require 'logue/loggable'
require 'open3'

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
    debug "cmd: #{cmd}"
    
    Open3.popen3(cmd) do |stdin, stdout, stderr, wthr|
      @output = stdout.readlines
      @error = stderr.readlines
      @status = wthr.value
    end

    if false && @output
      puts "output"
      @output.each_with_index do |line, idx|
        debug "output[#{idx}]: #{line}"
      end
    end
    
    if false && @error
      puts "error"
      @error.each_with_index do |line, idx|
        debug "error[#{idx}]: #{line}"
      end
    end

    debug "@status: #{@status}"
    
    @output
  end

  def to_command
    @args.join ' '
  end
end
