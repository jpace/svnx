#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'logue/loggable'

module Svnx
  module Base
  end
end

class Svnx::Base::Entry
  include Logue::Loggable

  def initialize xmllines: nil, xmlelement: nil
    if xmllines
      if xmllines.kind_of? Array
        xmllines = xmllines.join ''
      end

      doc = REXML::Document.new xmllines

      set_from_xml doc
    elsif xmlelement
      set_from_element xmlelement
    else
      raise "must be initialized with xmllines or xmlelement"
    end
  end

  def set_from_xml xmldoc
    raise "must be implemented"
  end

  def set_from_element elmt
    raise "must be implemented"
  end

  def get_attribute xmlelement, attrname
    xmlelement.attributes[attrname.to_s]
  end

  def get_element_text xmlelement, elmtname
    elmt = xmlelement.elements[elmtname.to_s]
    # some elements don't have text:
    (elmt && elmt.text) || ""
  end

  def set_attr_var xmlelement, varname
    set_var varname, get_attribute(xmlelement, varname)
  end

  def set_attr_vars xmlelement, *varnames
    varnames.each do |varname|
      set_attr_var xmlelement, varname
    end
  end

  def set_elmt_var xmlelement, varname
    set_var varname, get_element_text(xmlelement, varname)
  end

  def set_elmt_vars xmlelement, *varnames
    varnames.each do |varname|
      set_elmt_var xmlelement, varname
    end
  end

  def set_var varname, value
    instance_variable_set '@' + varname.to_s, value
  end
end
