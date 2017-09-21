#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pp'

dir = File.dirname(File.dirname(File.expand_path(__FILE__)))
libpath = dir + "/lib"
$:.unshift libpath

require 'yira/ticket'
require 'yira/query'
require 'yira/fetcher/options'
require 'logue/loggable'

Logue::Log.level = Logue::Log::INFO

module Fetcher
end

class Fetcher::App
  include Logue::Loggable
  
  def initialize args
    options = Yira::Fetcher::Options.new args
    name = options.name

    query = Yira::Query.new options

    json = query.result
    issues = json["issues"]
    
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
