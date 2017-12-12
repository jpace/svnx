#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Info
  end
end

module Svnx::Info
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :url, :path ]
    
    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :revision
        [ "-r", revision ] 
      else
        send field
      end
    end
  end
end
