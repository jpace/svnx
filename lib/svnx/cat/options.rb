#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Cat
  end
end

module Svnx::Cat
  class Options < Svnx::Base::Options
    has :revision, :path, :url
  end
end
