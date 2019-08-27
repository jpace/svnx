#!/usr/bin/ruby -w
# -*- ruby -*-

module Svnx
  class Action
    include Comparable

    class << self
      def new *args
        if args.length == 2
          super
        else
          type = args.first
          types = constants false
          types.each do |t|
            tc = const_get t
            if tc.type == type.to_sym || tc.abbrev == type
              return tc
            end
          end
          raise "not a valid action type: #{type}"
        end
      end
    end

    attr_reader :type
    attr_reader :abbrev
    
    def initialize type, abbrev
      @type = type.to_sym
      @abbrev = abbrev
    end

    def <=> other
      @type <=> other.type
    end

    def to_s
      @type.to_s
    end
    
    Hash[
      :added       => 'A',
      :deleted     => 'D',
      :modified    => 'M',
      :replaced    => 'R',
      :unversioned => '?',
      :missing     => '?',
      :external    => 'X',
      :normal      => 'q' # actually, X, but in a different column than X for external
    ].each do |sym, char|
      str = sym.to_s
      action = new str, char
      Action.const_set str.upcase, action
      methname = str + '?'
      define_method methname do
        @type.to_sym == sym
      end      
    end
  end
end
