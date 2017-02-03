#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/log/options'
require 'svnx/log/entries'
require 'svnx/base/command'

class Svnx::Log::Command < Svnx::Base::Command
  include Svnx::Base::NonCaching
  include Svnx::Base::XmlOutput
  
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute

    if not @output.empty? 
      @entries = Svnx::Log::Entries.new xmllines: @output
    end
  end
end
