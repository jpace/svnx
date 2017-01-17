#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/args'
require 'svnx/commit/options'

class Svnx::Commit::Args < Svnx::Base::Args
  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :file,   [ "-F", @options.file ] ]
      optargs << [ :url,    @options.url ]
      optargs << [ :paths,  @options.paths ]
    end
  end
end
