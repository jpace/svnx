#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

module Fetcher
end

class Fetcher::Options
  attr_reader :name
  attr_reader :status
  attr_reader :key
  attr_reader :project
  attr_reader :issuetype
  attr_reader :version
  attr_reader :assignee
  
  def initialize args
    @name = nil
    @status = "Open, Scheduled"
    @key = nil
    @project = "PIE"
    @issuetype = "Fix"
    @version = nil
    @assignee = ENV["USER"]

    while arg = args.shift
      case arg
      when "--name", "-n"
        @name = Regexp.new args.shift
      when "--status", "-s"
        @status = args.shift
      when "--any-status"
        @status = nil
      when "--key", "-k"
        @key = args.shift
      when "--version", "-v"
        @version = args.shift
      when "--type", "-t"
        @issuetype = args.shift
      when "--assignee", "-a"
        @assignee = args.shift
      when "--no-assignee"
        @assignee = nil
      end
    end
  end
end
