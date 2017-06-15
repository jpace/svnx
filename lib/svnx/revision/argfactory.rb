#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  module Revision
    RELATIVE_REVISION_RE = Regexp.new '^([\+\-])(\d+)$'
  end
end

module Svnx::Revision
  class ArgumentFactory
    include Logue::Loggable

    DATE_REGEXP = Regexp.new '^\{(.*?)\}'
    SVN_ARGUMENT_WORDS = %w{ HEAD BASE COMMITTED PREV }

    def create value, args = Hash.new
      case value
      when Fixnum
        create_for_fixnum value, args
      when String
        create_for_string value, args
      when Symbol
        raise RevisionError.new "symbol not yet handled"
      when Date
        # $$$ this (and Time) will probably have to be converted to svn's format
        raise RevisionError.new "date not yet handled"
      when Time
        raise RevisionError.new "time not yet handled"
      end          
    end

    def create_for_fixnum value, args
      if value < 0
        # these are log entries:
        RelativeArgument.new value, entries: args[:entries]
      else
        IndexArgument.new value
      end
    end

    def create_for_string value, args
      case 
      when SVN_ARGUMENT_WORDS.include?(value)
        StringArgument.new value
      when md = RELATIVE_REVISION_RE.match(value)
        RelativeArgument.new md[0].to_i, entries: args[:entries]
      when DATE_REGEXP.match(value)
        StringArgument.new value
      else
        IndexArgument.new value.to_i
      end
    end
  end
end
