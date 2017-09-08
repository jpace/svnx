#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira/defect'
require 'yira/fix'

class Yira::TicketFactory
  def create issue
    type = issue["fields"]["issuetype"]["name"]
    cls = issue_type_to_class type
    cls.new issue
  end
  
  def issue_type_to_class type
    Object::const_get type.to_sym
  end
end
