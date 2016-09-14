# Count the frequency of each word in the text string excluding the words
# in the exclusion list
# return a hash containing word=>count
def count_frequencies(text, exclude)
  exclude = exclude.map(&:downcase)
  text_array = text.split(/[^\w']/)
  frequencies = Hash.new(0)
  for word in text_array
    if not exclude.include?(word.downcase)
      frequencies[word.downcase] += 1
    end
  end
  return frequencies
end

# Given a text string, return a list of words within the text of length
# between 1 and text.uniq.length-1
def generate_exclude_list(text)
  text_array = text.downcase.split(/[^\w']/)
  text_array = text_array.uniq
  if text_array.length <= 1
    exclude_count = 0
  else
    exclude_count = rand(1...text_array.length)
  end
  exclude = text_array.sample(exclude_count)
  return exclude
end

# Return true if both hashes contain the same key=>value pairs, ignoring the
# case of the keys
def equivalent_hash?(a, b)
  lower_a = Hash[a.map { |k, v| [k.downcase, v] }]
  lower_b = Hash[b.map { |k, v| [k.downcase, v] }]
  return lower_a == lower_b
end
