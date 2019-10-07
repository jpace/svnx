#!/usr/bin/ruby -w
# -*- ruby -*-

require 'svnx/merge/options'
require 'svnx/tc'

module Svnx::Merge
  class OptionsTest < Svnx::TestCase
    def self.build_send_params
      [
        [ { change:   123 } ],
        [ { revision: "123:456" } ],
        [ { accept:   "postpone" } ],
        [ { from:     "a/b" } ],
        [ { to:       "a/b" } ],
        [ { change: nil, revision: nil, accept: nil, from: nil, to: nil, non_interactive: nil }, Hash.new ]
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
      [ [ "--change", 123 ],         change: 123 ],
      [ [ "--revision", "123:456" ], revision: "123:456" ],
      [ [ "--accept", "postpone" ],  accept: "postpone" ],
      [ [ "p://abc" ],               from: "p://abc" ],
      [ [ "p://abc", "q://def" ],    from: "p://abc", to: "q://def" ],
      [ [ "p://abc" ],               from: "p://abc" ],
      [ [ "a/b" ],                   from: "a/b" ],
      [ [ "--non-interactive" ],     non_interactive: true ],
    ] do |exp, vals|
      opts = Options.new vals
      assert_equal exp, opts.to_args
    end

    param_test [
      :change, :revision, :accept, :from, :to
    ] do |exp|
      opts = Options.new change: nil, revision: nil, accept: nil, from: nil, to: nil
      fields = opts.fields
      assert fields.has_key? exp
    end
  end
end
