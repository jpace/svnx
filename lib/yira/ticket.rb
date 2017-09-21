#!/usr/bin/ruby -w
# -*- ruby -*-

require 'yira'
require 'yira/defect'
require 'yira/fix'
require 'logue/loggable'

class Yira::TicketFactory
  include Logue::Loggable
  
  def create issue
    type = issue["fields"]["issuetype"]["name"]
    cls = issue_type_to_class type
    cls.new issue
  end
  
  def issue_type_to_class type
    Object::const_get type.to_sym
  end
end
