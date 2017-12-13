#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Commit
  end
end

module Svnx::Commit
  class Options < Svnx::Base::Options
    FIELDS = Hash.new.tap do |h|
      h[:file]  = Proc.new { |x| [ "-F", x.file ] }
      h[:paths] = nil
    end

    has_fields FIELDS.keys

    def fields
      FIELDS
    end
  end
end
