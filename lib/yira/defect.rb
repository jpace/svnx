#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/util'
require 'yira/issue'

class Defect < Issue
  attr_reader :summary
  attr_reader :status
  attr_reader :version

  def initialize json
    super
    
    fields = json["fields"]
    @summary = fields["summary"]
    @status = fields["status"]["name"]
    @version = fields["customfield_10299"]["name"]
  end

  def print
    println "key", @key
    println "summary", @summary
    println "status", @status
    println "version", @version
    puts
  end
end
