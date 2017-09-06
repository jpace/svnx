#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira'
require 'yira/defect'
require 'yira/fix'

class TicketFactory
  def create issue
    cls = issue_type_to_class issue
    cls.new issue
  end
  
  def issue_type_to_class issue
    type = issue["fields"]["issuetype"]["name"]
    puts "type: #{type}"
    cls = Object::const_get type.to_sym
    puts "cls: #{cls}"
    cls
  end
end
