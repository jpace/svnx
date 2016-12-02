#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'
require 'json'
require 'pp'

dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
libpath = dir + "/lib"
$:.unshift libpath

require 'yira'

require 'pathname'

class FetchItrac
  def initialize args
    json = Yira.new.get_url "https://itrac.eur.ad.sag/rest/api/2/issue/PIE-43769"
    
    puts "json.keys: #{json.keys}"
    pp json
    
    summary = json['fields']['summary']
    puts "summary: #{summary}"
    tgtversion = json['fields']['environment'].split("\n").detect { |x| x.index "Reported Version" }[19 .. -1]
    puts "tgtversion: #{tgtversion}"

  end

  def q str
    "'" + str + "'"
  end

  def qq str
    '"' + str + '"'
  end
end

FetchItrac.new ARGV
