#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/tc'

module Svnx::Merge
  class OptionsTest < Svnx::TestCase
    def self.build_send_params
      [
        [ { commit: 123 } ],
        [ { range:  "123: 456" } ],
        [ { accept: "postpone" } ],
        [ { from:   "a/b" } ],
        [ { to:     "a/b" } ],
        [ { commit: nil, range: nil, accept: nil, from: nil, to: nil }, Hash.new ]
      ].collect do |vals|
        [ vals.first, vals.last ]
      end
    end
    
    param_test build_send_params do |expvals, vals|
      opts = Options.new vals
      expvals.each do |methname, expval|
        result = opts.send methname
        assert_equal expval, result
      end
    end

    param_test [
      [ Array.new, Hash.new ],
      [ [ "-c", 123 ],              commit: 123 ],
      [ [ "-r", "123:456" ],        range: "123:456" ],
      [ [ "--accept", "postpone" ], accept: "postpone" ],
      [ [ "p://abc" ],              from: "p://abc" ],
      [ [ "p://abc", "q://def" ],   from: "p://abc", to: "q://def" ],
      [ [ "p://abc" ],              from: "p://abc" ],
      [ [ "a/b" ],                  from: "a/b" ],
    ] do |exp, vals|
      opts = Options.new vals
      assert_equal exp, opts.to_args
    end

    param_test [
      :commit, :range, :accept, :from, :to
    ] do |exp|
      opts = Options.new commit: nil, range: nil, accept: nil, from: nil, to: nil
      fields = opts.fields
      assert fields.has_key? exp
    end
  end
end
