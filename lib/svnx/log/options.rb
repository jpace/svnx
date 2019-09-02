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
    has_tag_argument :limit, :depth
    has_tag_field :verbose, :stop_on_copy, :use_merge_history
    has :revision, :url, :path
  end
end
