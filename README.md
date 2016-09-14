# WordCount
RESTful API CAPTCHA requiring humans to count the occurances of words in a sentence, given a list of exclusion words.  

[![Build Status](https://travis-ci.org/Curly-Mo/word_count_validator.svg?branch=master)](https://travis-ci.org/Curly-Mo/word_count_validator) 
[![Coverage Status](https://coveralls.io/repos/github/Curly-Mo/word_count_validator/badge.svg?branch=master)](https://coveralls.io/github/Curly-Mo/word_count_validator?branch=master)  
A live version is available at: https://animoto-word-count.herokuapp.com/

## Installation
```
bundle install
```

## Run Server
```
bundle exec rackup config.ru -s Puma -p $PORT
```
or simply execute
```
./run
```

## Usage
### Get text
```
curl -X GET -w '%{http_code}' "localhost:8000"
```
Example Response:
```
{
  "text": "The quick brown fox jumps over the lazy dog.",
  "exclude": ["the", "dog"]
} 
200
```
### Validate count
#### Wrong Attempt
```
curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"text":"The quick brown fox jumps over the lazy dog", "exclude": ["the", "dog"], "frequency":{"the":2, "dog":1, "quick":1, "brown":1, "fox":1, "jumps":1, "over":1, "lazy":1}}' -w '%{http_code}' localhost:8000
```
Expected Response:
```
{
  "message": Nice try, space troll
}
400
```
#### Correct Attempt
```
curl -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"text":"The quick brown fox jumps over the lazy dog", "exclude": ["the", "dog"], "frequency":{"quick":1, "brown":1, "fox":1, "jumps":1, "over":1, "lazy":1}}' -w '%{http_code}' localhost:8000
```
Expected Response:
```
{
  "message": Correct!
}
200
```

# Notes
Bonus: The idea of remembering the last text sent to a user goes against the fundamental concept of stateless communication that is a core aspect a RESTful API. This could be done with user authentication and preserving the state of user interaction on the server. But if you are already authenticating users, what is the purpose of a CAPTCHA?  
Perhaps there is a simple alternative I am not thinking of, but for this short challenge I decided not to implement this bonus.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
