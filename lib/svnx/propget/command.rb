#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/propget/options'
require 'svnx/base/command'

class Svnx::Propget::Command < Svnx::Base::Command
  attr_reader :entries
  
  def initialize cmdopts = Hash.new
    super cls: Svnx::Base::CommandLine, xml: true, caching: false, options: cmdopts
    unless @output.empty? 
      @entries = Svnx::Propget::Entries.new xmllines: @output
    end
  end
end
