#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  REVISION_FIELD = Proc.new { |x| [ "-r", x.revision ] }

  REVISION_PATHS_URLS_FIELDS = Hash.new.tap do |h|
    h[:revision] = REVISION_FIELD
    h[:paths]    = nil
    h[:urls]     = nil
  end
  
  class Options
    include Svnx::ObjectUtil

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
      if fields.has_key? field
        if blk = fields[field]
          case blk
          when Proc
            blk.call self
          else
            blk
          end
        else
          send field
        end
      else
        send field
      end
    end    
  end
end
