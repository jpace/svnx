#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'
require 'yira/issue'

class Defect < Issue
  attr_reader :summary
  attr_reader :status
  attr_reader :version
  attr_reader :resolved_by

  def initialize json
    super
    
    fields = json["fields"]
    @summary = fields["summary"]
    @status = fields["status"]["name"]
    @version = fields["customfield_10299"]["name"]
    @resolved_by = Array.new
    if issuelinks = fields["issuelinks"]
      issuelinks.each do |ilnk|
        inward = ilnk["inwardIssue"]
        if inward && ilnk["type"]["inward"] == "is resolved by"
          lnkid = inward["key"]
          lnkname = inward["fields"]["summary"]

          @resolved_by << { id: lnkid, name: lnkname }
        end
      end
    end
  end

  def print
    println "key", @key
    println "summary", @summary
    println "status", @status
    println "version", @version
    nresolved_by = @resolved_by.length
    println "resolved_by", nresolved_by.to_s + " " + (nresolved_by == 1 ? "fix" : "fixes")
    resolved_by.each_with_index do |link, idx|
      println "", link[:id] + " - " + link[:name]
    end
    puts
  end
end
