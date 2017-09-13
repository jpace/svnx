#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira'
require 'yira/fetcher/options'
require 'logue/loggable'

class Yira::Query
  include Logue::Loggable
  
  attr_reader :result

  def initialize options
    query = create_query options    
    limit = '"startAt":0,"maxResults":99'
    fields =  %w{ id key summary status created updated customfield_10251 customfield_10260 issuelinks fixVersions issuetype customfield_10299 }
    
    dstr = build_data query, limit, fields
    info "dstr: #{dstr}"
    
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
    info "elements: #{elements}"
    elements.join(", ").brace
  end
end
