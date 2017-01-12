#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/info/options'

class Svnx::Info::Args
  def initialize options
    @options = options
  end

  def to_svn_args
    Array.new.tap do |args|
      options_to_args.each do |opt|
        optname = opt[0]
        values = opt[1]
        if @options.send optname
          args.concat [ values ].flatten
        end
      end
    end
  end

  def options_to_args
    Array.new.tap do |optargs|
      optargs << [ :revision, [ "-r", @options.revision ] ]
      optargs << [ :url,      @options.url ]
      optargs << [ :path,     @options.path ]
    end
  end
end
