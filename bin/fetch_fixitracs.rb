#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pp'
require 'time'

dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
libpath = dir + "/lib"
$:.unshift libpath

require 'yira'
require 'yira/util'

class String
  include StringUtil
end

module ObjectUtil
  def assign args, *symbols
    symbols.each do |symbol|
      # @var = args[:var]
      code = "@" + symbol.to_s + " = args[:" + symbol.to_s + "]"
      instance_eval code
    end
  end
end

class Fix
  include ObjectUtil
  
  attr_reader :key
  attr_reader :name
  attr_reader :status
  attr_reader :build_date
  attr_reader :release_date
  attr_reader :resolves
  attr_reader :version

  def initialize args = Hash.new
    assign args, :key, :name, :status, :build_date, :release_date, :resolves, :version
  end


  def ymd str
    str && Time.parse(str).strftime("%Y-%m-%d")
  end

  def println field, value
    printf "%-12s: %s\n", field, value
  end

  def print
    println "name", @name
    println "key", @key
    println "version", @version
    println "status", @status
    println "build date", ymd(@build_date)
    println "release date", ymd(@release_date)
    println "resolves", @resolves.keys.length.to_s + " issues"

    @resolves.sort.each do |okey, issue|
      println "", okey + " - " + issue["fields"]["summary"]
    end
    puts
  end
end

class FetchFixItracs
  def initialize args
    filter = nil
    if args.first == "-n"
      args.shift
      filter = Regexp.new args.shift
    end

    # https://itrac.eur.ad.sag/secure/IssueNavigator.jspa?mode=hide&requestId=153486"
    
    # fields
    query = "project = PIE and issuetype = Fix and status in (Open, Scheduled)"
    limit = '"startAt":0,"maxResults":1152'
    fields = %w{ id key summary status created updated customfield_10251 customfield_10260 issuelinks fixVersions }
    
    dstr = build_data query, limit, fields
    puts "dstr: #{dstr}"
    
    json = Yira.new.post_url dstr, "https://itrac.eur.ad.sag/rest/api/2/search"
    
    puts "json.keys: #{json.keys}"
    # pp json

    issues = json["issues"]
    puts "issues.size: #{issues.size}"
    
    fixes = Array.new

    issues.each do |issue|
      # pp issue
      
      resolves = Hash.new

      issue["fields"]["issuelinks"].each do |ilink|
        if outissue = ilink["outwardIssue"]
          resolves[outissue["key"]] = outissue
        end
      end

      fix = Fix.new(key:          issue["key"],
                    name:         issue["fields"]["summary"],
                    version:      issue["fields"]["fixVersions"][0]["name"],
                    status:       issue["fields"]["status"]["name"],
                    build_date:   issue["fields"]["customfield_10251"],
                    release_date: issue["fields"]["customfield_10260"],
                    resolves:     resolves)

      if filter.nil? || filter.match(fix.name)
        fixes << fix
      end
    end

    fixes.sort_by { |fix| fix.version }.each do |fix|
      fix.print
    end
  end

  def ymd str
    str && Time.parse(str).strftime("%Y-%m-%d")
  end

  def println field, value
    printf "%-12s: %s\n", field, value
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
