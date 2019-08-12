#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    has_fields commit:           to_args("-c", :commit),
               ignoreproperties: "--ignore-properties",
               depth:            to_args("--depth", :depth)
    
    has :ignorewhitespace, :paths, :url
  end
end
