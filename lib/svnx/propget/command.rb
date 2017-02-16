#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/base/command'

class Svnx::Propget::Command < Svnx::Base::EntriesCommand
  noncaching
end
