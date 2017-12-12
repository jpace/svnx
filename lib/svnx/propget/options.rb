#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options
    FIELDS = [ :revision, :revprop, :name, :url, :path ]

    has_fields FIELDS

    def fields
      FIELDS
    end

    def get_args field
      case field
      when :revision
        [ "-r", revision ] 
      when :revprop
        "--revprop"
      else
        send field
      end
    end
  end
end
