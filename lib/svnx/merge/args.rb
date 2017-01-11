#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'

class SvnMergeArgs
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
    # an array, not a hash, because "from" should be in the exec args before "url"/"path"
    Array.new.tap do |optargs|
      optargs << [ :commit, [ "-c", @options.commit ] ]
      optargs << [ :range,  [ "-r", @options.range ] ]
      optargs << [ :accept, [ "--accept", @options.accept ] ]
      optargs << [ :from,   @options.from ]
      optargs << [ :url,    @options.url ]
      optargs << [ :path,   @options.path ]
    end
  end
end
