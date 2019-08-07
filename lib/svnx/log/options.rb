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
    has_fields limit:             Proc.new { |x| [ "--limit", x.send(:limit) ] },
               verbose:           "-v",
               stop_on_copy:      to_tag(:stop_on_copy),
               use_merge_history: "--use-merge-history",
               depth:             Proc.new { |x| [ "--depth", x.send(:depth) ] }
    has :revision, :url, :path
  end
end
