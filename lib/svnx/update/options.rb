#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Update
  end
end

module Svnx::Update
  class Options < Svnx::Base::Options
    has :revision, :paths
    has_tag_arguments :depth, :set_depth
    has_tag_field :ignore_externals
  end
end
