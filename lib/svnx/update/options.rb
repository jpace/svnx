#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Update
  end
end

module Svnx::Update
  class Options < Svnx::Base::Options
    has :revision
    has :paths
  end
end
