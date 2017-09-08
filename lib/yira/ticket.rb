#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira'
require 'yira/defect'
require 'yira/fix'

class Yira::TicketFactory
  def create issue
    type = issue["fields"]["issuetype"]["name"]
    cls = issue_type_to_class type
    cls.new issue
  end
  
  def issue_type_to_class type
    puts "type: #{type}"
    Object::const_get(type.to_sym).tap do |cls|
      puts "cls: #{cls}"
    end
  end
end
