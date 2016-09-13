def count_frequencies(text, exclude)
  exclude = exclude.map(&:downcase)
  text_array = text.split(/\W/)
  frequencies = Hash.new(0)
  for word in text_array
    if not exclude.include?(word.downcase)
      frequencies[word] += 1
    end
  end
  return frequencies
end

def generate_exclude_list(text)
  text_array = text.downcase.split(/\W/)
  if text_array.length < 1
    exclude_count = 0
  else
    exclude_count = rand(1...text_array.length)
  end
  exclude = text_array.sample(exclude_count)
  exclude = exclude.uniq
  return exclude
end

def equivalent_hash?(a, b)
  lower_a = Hash[a.map { |k, v| [k.downcase, v] }]
  lower_b = Hash[b.map { |k, v| [k.downcase, v] }]
  return lower_a == lower_b
end
