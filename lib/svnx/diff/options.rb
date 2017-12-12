#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    FIELDS = [ :commit, :ignoreproperties, :ignorewhitespace, :paths, :url, :depth ]
    
    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :commit
        [ "-c", commit ]
      when :ignoreproperties
        "--ignore-properties" 
      when :depth
        [ "--depth", depth ] 
      when :ignorewhitespace
        [ "-x", "-bw" ]
      else
        send field
      end
    end
  end
end
