#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    FIELDS = Hash.new.tap do |h|
        h[:commit]           = Proc.new { |x| [ "-c", x.commit ] }
        h[:ignoreproperties] = "--ignore-properties"
        h[:depth]            = Proc.new { |x| [ "--depth", x.depth ] }
        h[:ignorewhitespace] = [ "-x", "-bw" ]
        h[:paths]            = nil
        h[:url]              = nil
    end
    
    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
