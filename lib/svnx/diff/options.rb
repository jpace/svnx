#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    has_fields commit:           Proc.new { |x| [ "-c", x.commit ] },
               ignoreproperties: "--ignore-properties",
               depth:            Proc.new { |x| [ "--depth", x.depth ] }

    has :ignorewhitespace, :paths, :url
  end
end
