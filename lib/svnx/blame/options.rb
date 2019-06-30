#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/options'

module Svnx
  module Blame
  end
end

module Svnx::Blame
  class Options < Svnx::Base::Options
    has :revision, :paths, :urls, :ignorewhitespace
  end
end
