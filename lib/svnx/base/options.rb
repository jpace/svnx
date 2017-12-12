#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/util/objutil'

module Svnx
  module Base
  end
end

module Svnx::Base
  class Options
    include Svnx::ObjectUtil

    def options_to_args
      fields.collect do |fld|
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
  end
end
