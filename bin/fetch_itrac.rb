#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'
require 'json'
require 'pp'

dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
libpath = dir + "/lib"
$:.unshift libpath

require 'yira'
require 'yira/defect'
require 'yira/fix'
require 'yira/util'
require 'yira/ticket'
require 'yira/fetcher/options'
require 'logue/loggable'

class Yira::QueryParams
  attr_reader :project
  attr_reader :issuetype
  attr_reader :assignee
  attr_reader :status

  def initialize args = Hash.new
    @project = args[:project]
    @issuetype = args[:issuetype]
    @assignee = args[:assignee]
    @status = args[:status]
  end
end

class Yira::Query
  attr_reader :result

  def initialize options
    query = create_query options    
    limit = '"startAt":0,"maxResults":99'
    fields =  %w{ id key summary status created updated customfield_10251 customfield_10260 issuelinks fixVersions issuetype customfield_10299 }
    
    dstr = build_data query, limit, fields
    puts "dstr: #{dstr}"
    
    @result = Yira.new.post_url dstr, "https://itrac.eur.ad.sag/rest/api/2/search"
  end

  def create_query options
    if options.key
      "key = " + options.key
    else
      elements = Array.new.tap do |ary|
        if options.project
          ary << "project = " + options.project
        end
        if options.issuetype
          ary << "issuetype = " + options.issuetype
        end
        if options.assignee
          ary << "assignee in (" + options.assignee + ")"
        end
        if options.status
          ary << "status in (" + options.status + ")"
        end
      end
      elements.join " and "
    end
  end

  def build_data query, limit, fields
    elements = [ "jql".qq + ":" + query.qq ]
    if limit
      elements << limit
    end
    if fields && !fields.empty?
      elements << "fields".qq + ":" + fields.collect { |x| x.qq }.join(",").bracket
    end
    puts "elements: #{elements}"
    elements.join(", ").brace
  end
end

class Fetcher::App
  def initialize args
    options = Fetcher::Options.new args
    name = options.name

    query = Yira::Query.new options

    json = query.result
    
    issues = json["issues"]
    puts "issues.size: #{issues.size}"

    tfact = Yira::TicketFactory.new
    
    tickets = issues.collect do |issue|
      tfact.create issue
    end

    if name
      tickets = tickets.select do |ticket|
        name.match ticket.name
      end
    end
    
    if options.version
      tickets = tickets.select do |ticket|
        options.version == ticket.version
      end
    end
    
    tickets.sort_by { |ticket| ticket.version }.each do |ticket|
      ticket.print
    end
  end
end

Fetcher::App.new ARGV
