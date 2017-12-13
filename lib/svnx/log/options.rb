#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Options < Svnx::Base::Options
    FIELDS = Hash.new.tap do |h|
      h[:limit]    = Proc.new { |x| [ "--limit", x.limit ] }
      h[:verbose]  = "-v"
      h[:revision] = Proc.new { |x| "-r" + x.revision.to_s }
      h[:url]      = nil
      h[:path]     = nil
    end

    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
