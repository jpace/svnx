#!/usr/bin/ruby -w
# -*- ruby -*-

require 'rexml/document'
require 'logue/loggable'

module Svnx
  class Cmd
    include Logue::Loggable
    
    def initialize xml
      info "xml: #{xml}"

      @doc = REXML::Document.new xml
      info "@doc: #{@doc}"

    end
  end
end
  
