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
      h[:paths]            = nil
      h[:url]              = nil
    end.merge(Svnx::Base::IGNORE_WHITESPACE)
    
    has_fields FIELDS
  end
end
