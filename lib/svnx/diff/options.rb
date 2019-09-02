#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Diff
  end
end

module Svnx::Diff
  class Options < Svnx::Base::Options
    has_tag_argument :change, :depth
    has_tag_field :ignore_properties
    has :ignore_whitespace, :paths, :url
  end
end
