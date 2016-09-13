require "./spec/spec_helper"
require './helpers/word_count'
require 'extlib_lite'

describe 'The Word Counting Helpers' do
  describe 'count_frequencies' do
    it "counts correctly" do
      expect(
        count_frequencies("foo bar baz", []).stringify
      ).to eq(
        {"foo": 1, "bar": 1, "baz":1}.stringify
      )
    end
    it "excludes correctly" do
      expect(
        count_frequencies("foo bar baz", ["bar"]).stringify
      ).to eq(
        {"foo": 1, "baz":1}.stringify
      )
    end
    it "handles case and punctuation" do
      expect(
        count_frequencies("Foo bA'r baZ.", []).stringify
      ).to eq(
        {"foo": 1, "ba'r": 1, "baz":1}.stringify
      )
    end
  end

  describe 'generate_exclude_list' do
    it "excludes all in sentence" do
      expect(
        generate_exclude_list("foo bar baz")
      ).to all(satisfy {
         |v| ["foo", "bar", "baz"].include?(v)
      })
    end
    it "excludes at least one" do
      expect(
        generate_exclude_list("foo bar baz").count
      ).to be >= 1
    end
    it "be empty when only 1 word" do
      expect(
        generate_exclude_list("foo")
      ).to be_empty
    end
    it "contain not all words" do
      expect(
        generate_exclude_list("foo bar baz five words").count
      ).to be < 5
    end
  end
end
