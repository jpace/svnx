#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'
require 'svnx/util/strutil'

module Svnx
  module Log
  end
end

module Svnx::Log
  class Options < Svnx::Base::Options
    has_fields limit:             to_args("--limit", :limit),
               verbose:           "-v",
               stop_on_copy:      to_tag(:stop_on_copy),
               use_merge_history: to_tag(:use_merge_history),
               depth:             to_args("--depth", :depth)
    has :revision, :url, :path
  end
end
