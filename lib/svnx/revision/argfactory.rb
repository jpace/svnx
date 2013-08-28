#!/usr/bin/ruby -w
# -*- ruby -*-

module SVNx; module Revision; end; end

module SVNx::Revision  
  class ArgumentFactory
    include Logue::Loggable

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
        RelativeArgument.orig_new value, entries: args[:entries]
      else
        IndexArgument.orig_new value
      end
    end

    def create_for_string value, args
      case 
      when Argument::SVN_ARGUMENT_WORDS.include?(value)
        StringArgument.orig_new value
      when md = RELATIVE_REVISION_RE.match(value)
        RelativeArgument.orig_new md[0].to_i, entries: args[:entries]
      when Argument::DATE_REGEXP.match(value)
        StringArgument.orig_new value
      else
        IndexArgument.orig_new value.to_i
      end
    end
  end
end
