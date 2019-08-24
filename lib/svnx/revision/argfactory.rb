#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx::Revision  
  class ArgumentFactory
    include Logue::Loggable

    RELATIVE_REGEXP = Regexp.new '^([\+\-])(\d+)$'
    DATE_REGEXP = Regexp.new '^\{(.*?)\}'
    SVN_ARGUMENT_WORDS = %w{ HEAD BASE COMMITTED PREV }

    def create value, entries: nil
      case value
      when Fixnum
        create_for_fixnum value, entries: entries
      when String
        create_for_string value, entries: entries
      when Symbol
        raise RevisionError.new "symbol not yet handled"
      when Date
        # $$$ Date and Time will probably have to be converted to svn's format
        raise RevisionError.new "date not yet handled"
      when Time
        raise RevisionError.new "time not yet handled"
      end          
    end

    def create_for_fixnum value, entries: nil
      if value < 0
        # these are log entries:
        RelativeArgument.new value, entries: entries
      else
        IndexArgument.new value
      end
    end

    def create_for_string value, entries: nil
      case 
      when SVN_ARGUMENT_WORDS.include?(value)
        StringArgument.new value
      when md = RELATIVE_REGEXP.match(value)
        RelativeArgument.new md[0].to_i, entries: entries
      when DATE_REGEXP.match(value)
        StringArgument.new value
      else
        IndexArgument.new value.to_i
      end
    end
  end
end
