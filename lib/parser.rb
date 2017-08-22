class Parser

MULTIPLIER = 1

  attr_reader :data, :starting_pronouns, :parse_data

  def initialize
    @data = []
    @parse_data = []
    @starting_pronouns = [
      "he", "she", "i", "it", "you", "my", "it's", "they",
      "they'll", "he'll", "she'll", "you'll", "here's", "this", "people",
      "how", "why", "memes"
    ]
    @key_words = [
      "sex", "things", "number", "these", "believe", "tips", "tweets",
      "never", "photos", "photo", "best", "make", "just", "kardashian",
      "jenner", "memes", "people", "times", "worst", "questions", "never",
      "know", "this", "what", "ways"
    ]
    @key_phrases = [
      "here's why", "here's what", "you'll never", "that will", "this is", "how to",
      "the most", "what this", "when you", "and it's", "and we'll", "wait till",
      "this guy", "blow your", "the reason", "make you", "looks like", "pictures of",
      "the internet", "can you", "you didn't", "you need", "here's how", "it looks",
      "will make"
    ]

    @key_pronouns = [
      "i", "he", "she", "you", "my", "you'll", "me", "yours", "your", "you're", "mine", "their"
    ]

  end

  def load_file(file)
    File.foreach(file) { |line| @data << line.split("\n") }
  end

  def parse(determination)
    create_input_vectors(@data, determination == :good ? 0 : 1).each { |h| @parse_data.push(h)}
    @data = []
  end

  def parse_individual(determination, str)
    create_input_hash(str, determination)
  end

private

  def create_input_vectors(training_data, determination)
    training_data.map { |headline| create_input_hash(headline, determination) }
  end

  def create_input_hash(headline, determination)
    {
      vector: [MULTIPLIER,
               first_word(headline),
               key_words(headline),
               number_occurrences(headline),
               key_phrases(headline) + the_and_number(headline),
               key_pronouns(headline)],
      expected: determination
    }
  end

  def first_word(headline)
    @starting_pronouns.inject(0) { |r, w| headline.first.downcase.split(" ")[0].to_i != 0 &&
      headline.first.downcase.split(" ")[0].to_i < 50 &&
      r == 0 || headline.first.downcase.split(' ')[0] == w ? r + 1 : r }
  end

  def key_words(headline)
    @key_words.inject(0) { |r, word| headline.first.downcase.split(" ").include?(word) ? r + 1 : r }
  end

  def key_phrases(headline)
    @key_phrases.inject(0) { |r, phrase| headline.first.downcase.include?(phrase) ? r + 1 : r }
  end

  def key_pronouns(headline)
    @key_pronouns.reduce(0) { |r, word| headline.first.downcase.split(" ").include?(word) ? r + 1 : r }
  end

  def number_occurrences(headline)
    headline.first[0].scan(/\d+/).count
  end

  def is_i?(string)
    /\A[-+]?\d+\z/ === string
  end

  def the_and_number(headline)
    the_arr = headline.first.downcase.split(" ").each_index.select{|i| headline.first.downcase.split(" ")[i] == 'the'}
    the_arr.inject(0){|r, item| is_i?(headline.first.downcase.split(" ")[item + 1]) ? r + 1 : r }
  end
end
