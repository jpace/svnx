#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/base/cmdline'
require 'svnx/base/command'

class Svnx::Propget::CommandLine < Svnx::Base::CommandLine
  def uses_xml?
    true
  end
end

class Svnx::Propget::Command < Svnx::Base::Command
  include Logue::Loggable
  
  attr_reader :output
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super
    @output = @cmdline.execute
    unless @output.empty? 
      @entries = Svnx::Propget::Entries.new xmllines: @output
    end
  end
end
