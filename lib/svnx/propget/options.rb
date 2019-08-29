#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Propget
  end
end

module Svnx::Propget
  class Options < Svnx::Base::Options
    has_tag_field :revprop
    has :revision, :url, :path
    has_fields name: nil
  end
end
