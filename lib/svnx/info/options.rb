#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Info
  end
end

module Svnx::Info
  class Options < Svnx::Base::Options
    has :revision, :path, :url
  end
end
