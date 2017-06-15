#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/base/command'

module Svnx::Propget
  class Command < Svnx::Base::EntriesCommand
    noncaching
  end
end
