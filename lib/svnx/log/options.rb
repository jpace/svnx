#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Options < Svnx::Base::Options
    FIELDS = [ :limit, :verbose, :revision, :url, :path ]

    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :limit
        [ "--limit", limit ] 
      when :verbose
        "-v" 
      when :revision
        "-r" + revision.to_s 
      else
        send field
      end
    end    
  end
end
