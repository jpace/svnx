#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'
require 'yira/issue'

class Fix < Issue
  attr_reader :name
  attr_reader :status
  attr_reader :build_date
  attr_reader :release_date
  attr_reader :resolves
  attr_reader :version

  def initialize json
    super

    fields = json["fields"]
    @name = fields["summary"]
    @version = fields["fixVersions"][0]["name"]
    @status = fields["status"]["name"]
    @build_date = fields["customfield_10251"]
    @release_date = fields["customfield_10260"]

    @resolves = Hash.new

    fields["issuelinks"].each do |ilink|
      if outissue = ilink["outwardIssue"]
        @resolves[outissue["key"]] = outissue
      end
    end
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
