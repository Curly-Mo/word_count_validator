require 'sinatra'
require 'sinatra/reloader' if development?
require 'literate_randomizer'
require 'json-schema'
require_relative 'helpers/word_count'

class App < Sinatra::Base
  before do
    content_type :json
  end

  # Accept an HTTP GET request and return a text string and list of
  # exclusion words as JSON
  get '/' do
    source_text = LiterateRandomizer.sentence(words: 4..25)
    exclude = generate_exclude_list(source_text)
    body erb(:'get.json', locals: { source_text: source_text, exclude: exclude })
    status 200
  end

  # Accept a POST request, validate the parameters and return status 200 if the
  # frequency counts are correct and 400 otherwise
  post '/' do
    data = request.body.read
    # Valid json schema
    schema = {
      'id': 'validator',
      'type': 'object',
      'required': ['text', 'frequency'],
      'properties': {
        'text': {
          'type': 'string',
        },
        'exclude': {
          'type': 'array',
          'additionalProperties': {
            'type': 'string',
          }
        },
        'frequency': {
          'type': 'object',
          'additionalProperties': {
            'type': 'integer',
          }
        },
      }
    }
    # Validate
    valid = JSON::Validator.validate(schema, data)
    if !valid
      message = JSON::Validator.fully_validate(schema, data)
      halt(400,  erb(:'error.json', locals: { message: message }))
    end

    data = JSON.parse(data)
    text = data['text']
    exclude = data.fetch('exclude', [])
    frequency = data['frequency']

    actual_frequency = count_frequencies(text, exclude)
    if equivalent_hash?(frequency, actual_frequency)
      body erb(:'post.json', locals: { message: 'Correct!' })
      status 200
    else
      body erb(:'post.json', locals: { message: 'Nice try, space troll' })
      status 400
    end
  end

end
