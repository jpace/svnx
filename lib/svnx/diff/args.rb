#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/diff/options'

class SvnDiffArgs
  def initialize options
    @options = options
  end

  def to_svn_args
    Array.new.tap do |args|
      options_to_args.each do |optname, values|
        if @options.send optname
          args.concat [ values ].flatten
        end
      end
    end
  end

  def options_to_args
    Hash.new.tap do |optargs|
      optargs[:commit]           = [ "-c", @options.commit ]
      optargs[:ignoreproperties] = [ "--ignore-properties" ]
      optargs[:ignorewhitespace] = [ "-x", "-bw" ]
      optargs[:url]              = @options.url
      optargs[:path]             = @options.path
    end
  end
end
