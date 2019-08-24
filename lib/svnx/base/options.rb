#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/base/fields'
require 'svnx/base/tags'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Options
    include Svnx::Base::Tags
    include Svnx::Base::Fields
    
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
