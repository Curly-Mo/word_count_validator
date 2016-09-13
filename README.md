# WordCount
RESTful API CAPTCHA requiring humans to count the occurances of words in a sentences, given a list of exclusion words.  

[![Build Status](https://travis-ci.org/Curly-Mo/word_count_validator.svg?branch=master)](https://travis-ci.org/Curly-Mo/word_count_validator)  

## Installation
```
bundle install
```

## Run Server
```
bundle exec rackup -p PORT config.ru &
```

## Usage
### Get text
```
curl -X GET "localhost:PORT"
```
Example Response:
```
{
  "text": "The quick brown fox jumps over the lazy dog.",
  "exclude": ["The", "dog"]
}%  
```
### Validate count
#### Wrong Attempt
```
curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"text":"The quick brown fox jumps over the lazy dog", "exclude": ["the", "dog"], "frequency":{"the":2, "dog":1, "quick":1, "brown":1, "fox":1, "jumps":1, "over":1, "lazy":1}}' localhost:PORT
```
Expected Response:
```
400,
{
  "message": Nice try, space troll
}
```
```
curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"text":"The quick brown fox jumps over the lazy dog", "exclude": ["the", "dog"], "frequency":{"quick":1, "brown":1, "fox":1, "jumps":1, "over":1, "lazy":1}}' localhost:PORT
```
Expected Response:
```
200,
{
  "message": Correct!
}
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
