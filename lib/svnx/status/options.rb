#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Status
  end
end

module Svnx::Status
  class Options < Svnx::Base::Options
    has :revision, :paths, :url
  end
end
