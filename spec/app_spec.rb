require "./spec/spec_helper"
require "json"

describe 'The Word Counting App' do
  def app()
    App
  end

  describe 'get' do
    it "returns 200 and has the right keys" do
      get '/'
      expect(last_response).to be_ok
      parsed_response = JSON.parse(last_response.body)
      expect(parsed_response).to have_key("text")
      expect(parsed_response).to have_key("exclude")
    end
  end

  describe 'post' do
    it "returns 200" do
      post '/', {text: 'foo bar baz', exclude: ['bar'], frequency: {'foo': 1, 'baz': 1}}.to_json
      expect(last_response).to be_ok
    end

    it "returns 400, incorrect" do
      post '/', {text: 'foo bar baz', exclude: ['bar'], frequency: {'bar': 50}}.to_json
      expect(last_response).to be_a_bad_request
    end

    it "returns 400, invalid" do
      post '/', {text: 'foo bar baz', wrongkeyname: {'foo': 1, 'baz': 1}}.to_json
      expect(last_response).to be_a_bad_request
    end

    it "returns 400, wrong type" do
      post '/', {text: 'foo bar baz', frequency: {'foo': 'invalidstring', 'baz': 1}}.to_json
      expect(last_response).to be_a_bad_request
    end
  end
end
