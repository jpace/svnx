#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/args'
require 'svnx/update/options'

class Svnx::Update::Args < Svnx::Base::Args
  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :revision, [ "-r", @options.revision ] ]
      optargs << [ :url,      @options.url ]
      optargs << [ :paths,    @options.paths ]
    end
  end
end
