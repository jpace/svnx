#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propset
  end
end

module Svnx::Propset
  class Options < Svnx::Base::Options

    FIELDS = Hash.new.tap do |h|
      h[:name]     = nil
      h[:revision] = Proc.new { |x| [ "--revprop", "-r", x.revision ] }
      h[:file]     = Proc.new { |x| [ "--file", x.file ] }
      h[:value]    = nil
      h[:url]      = nil
      h[:path]     = nil
    end
    
    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
