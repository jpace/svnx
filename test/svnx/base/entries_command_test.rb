#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/entries_command'
require 'svnx/tc'

module Xyz
  class Options < Svnx::Base::Options
    def fields
      Hash.new
    end
  end
  
  class Command < Svnx::Base::EntriesCommand
    caching
  end
end

module Svnx::Base
  class EntriesCommandTest < Svnx::TestCase
    def test_default
      options = Hash.new
      Xyz::Command.new options
    end
  end
end
