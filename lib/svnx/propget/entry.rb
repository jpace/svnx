#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entry'

module Svnx
  module Propget
  end
end

class Svnx::Propget::Entry < Svnx::Base::Entry
  attr_reader :path
  attr_reader :name
  attr_reader :value
  
  def set_from_element elmt
    set_attr_vars elmt, :path

    prop = elmt.elements["property"]
    set_attr_vars prop, :name
    @value = prop.text
  end
end
