#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  REVISION_FIELD = Proc.new { |x| [ "-r", x.revision ] }
  IGNORE_WHITESPACE = { ignorewhitespace: %w{ -x -bw -x --ignore-eol-style } }

  REVISION_PATHS_URLS_FIELDS = { revision: REVISION_FIELD, paths: nil, urls: nil }
  
  class Options
    include Svnx::ObjectUtil

    def initialize args
      fkeys = fields.keys
      
      assign args, fkeys
      validate args, fkeys
    end
    
    def options_to_args
      fields.keys.collect do |fld|
        [ fld, get_args(fld) ]
      end
    end

    def fields
      raise "not implemented for #{self.class}"
    end
    
    def to_args
      options_to_args.collect do |opt|
        send(opt.first) ? opt[1] : nil
      end.compact.flatten
    end

    def get_args field
      val = fields[field]
      case val
      when Proc
        val.call self
      when nil
        send field
      else
        val
      end
    end    
  end
end
