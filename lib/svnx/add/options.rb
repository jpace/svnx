#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Add
  end
end

module Svnx::Add
  class Options < Svnx::Base::Options
    has :paths
  end
end
