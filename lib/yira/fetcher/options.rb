#!/usr/bin/ruby -w
# -*- ruby -*-

class Yira
  module Fetcher
  end
end

class Yira::QueryParams
  attr_reader :assignee
  attr_reader :issuetype
  attr_reader :project
  attr_reader :status

  def initialize args = Hash.new
    @project = args[:project]
    @issuetype = args[:issuetype]
    @assignee = args[:assignee]
    @status = args[:status]
  end
end

class Yira::Fetcher::Options
  attr_reader :assignee
  attr_reader :issuetype
  attr_reader :key
  attr_reader :name
  attr_reader :project
  attr_reader :status
  attr_reader :version
  
  def initialize args = Array.new
    @assignee = ENV["USER"]
    @issuetype = "Defect"
    @key = nil
    @name = nil
    @project = "PIE"
    @status = "Open, Scheduled"
    @version = nil

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
        
      when "--version"
        @version = args.shift
        
      when "--project"
        @project = args.shift
        
      when "--type", "-t"
        @issuetype = args.shift
        
      when "--any-type"
        @issuetype = nil
        
      when "--assignee", "-a"
        @assignee = args.shift
      when "--any-assignee"
        @assignee = nil
      end
    end
  end
end
