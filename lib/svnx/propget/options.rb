#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options    
    FIELDS = Hash.new.tap do |h|
      h[:revision] = Svnx::Base::REVISION_FIELD
      h[:revprop]  = "--revprop"
      h[:name]     = nil
      h[:url]      = nil
      h[:path]     = nil
    end

    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
