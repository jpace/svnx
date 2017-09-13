#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'
require 'yira/issue'

class Defect < Issue
  attr_reader :summary
  attr_reader :status
  attr_reader :version
  attr_reader :links

  def initialize json
    super
    
    fields = json["fields"]
    @summary = fields["summary"]
    @status = fields["status"]["name"]
    @version = fields["customfield_10299"]["name"]
    @links = Array.new
    if issuelinks = fields["issuelinks"]
      issuelinks.each do |ilnk|
        lnkst = ilnk["type"]["inward"]
        lnkid = ilnk["inwardIssue"]["key"]
        lnkname = ilnk["inwardIssue"]["fields"]["summary"]

        @links << { status: lnkst, id: lnkid, name: lnkname }
      end
    end
  end

  def print
    println "key", @key
    println "summary", @summary
    println "status", @status
    println "version", @version
    links.each_with_index do |link, idx|
      println link[:status].sub("is ", ""), link[:id] + " (" + link[:name] + ")"
    end
    puts
  end
end
