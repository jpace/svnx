#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/command'
require 'svnx/update/options'

module Svnx::Update
  class Command < Svnx::Base::Command
    noncaching
    nonxml
  end
end
