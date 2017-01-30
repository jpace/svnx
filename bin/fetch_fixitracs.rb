#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pp'
require 'time'

dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
libpath = dir + "/lib"
$:.unshift libpath

require 'yira'
require 'yira/defect'
require 'yira/fix'
require 'yira/util'

class String
  include StringUtil
end

module HashUtil
  def join kstr, vstr
    keys.collect do |key|
      key.to_s + kstr + self[key].to_s
    end.join vstr
  end

  def compact
    Hash.new.tap do |hsh|
      keys.each do |key|
        if key && self[key]
          hsh[key] = self[key]
        end
      end
    end
  end
end

class Hash
  include HashUtil
end

class FetchFixItracs
  def initialize args
    name = nil
    status = "Open, Scheduled"
    key = nil
    project = "PIE"
    issuetype = "Fix"
    version = nil

    while arg = args.shift
      case arg
      when "--name", "-n"
        name = Regexp.new args.shift
      when "--status", "-s"
        status = args.shift
      when "--key", "-k"
        key = args.shift
      when "--version", "-v"
        version = args.shift
      end
    end

    json = run_query key: key, status: status, project: project, issuetype: issuetype
    
    issues = json["issues"]
    puts "issues.size: #{issues.size}"
    
    tickets = issues.collect do |issue|
      # pp issue

      type = issue["fields"]["issuetype"]["name"]
      cls = Object::const_get type.to_sym
      cls.new issue
    end

    if name
      tickets = tickets.select do |ticket|
        name.match ticket.name
      end
    end
    
    if version
      tickets = tickets.select do |ticket|
        version == ticket.version
      end
    end
    
    tickets.sort_by { |ticket| ticket.version }.each do |ticket|
      ticket.print
    end
  end

  def run_query args = Hash.new
    query = if args[:key]
              "key = " + args[:key]
            else
              elements = Array.new.tap do |ary|
                if args[:project]
                  ary << "project = " + args[:project]
                end
                if args[:issuetype]
                  ary << "issuetype = " + args[:issuetype]
                end
                if args[:status]
                  ary << "status in (" + args[:status] + ")"
                end
              end
              elements.join " and "
            end
    
    limit = '"startAt":0,"maxResults":99'
    fields =  %w{ id key summary status created updated customfield_10251 customfield_10260 issuelinks fixVersions issuetype customfield_10299 }
    
    dstr = build_data query, limit, fields
    puts "dstr: #{dstr}"
    
    Yira.new.post_url dstr, "https://itrac.eur.ad.sag/rest/api/2/search"
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

FetchFixItracs.new ARGV
