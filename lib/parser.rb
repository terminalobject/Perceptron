class Parser

MULTIPLIER = 1

  attr_reader :data, :starting_pronouns, :parse_data

  def initialize
    @data = []
    @parse_data = []
    @starting_pronouns = ["He", "She", "I", "It", "You", "My", "It's", "They", "They'll", "He'll", "She'll", "You'll"]
    @key_words = ["sex", "things", "number", "you'll", "these", "believe", "tips", "tweets", "never", "photos", "photo", "best", "make", "just"]
    @key_phrases = ["here's why", "here's what", "you'll never", "that will", "this is", "how to", "the most", "what this", "when you", "and it's",
                    "wait till", "this guy", "blow your", "the reason", "make you", "looks like", "pictures of"]
  end

  def load_file(file)
    File.foreach(file) { |line| @data << line.split("\n") }
  end

  def parse(determination)
    create_input_vectors(@data, determination == :good ? 0 : 1).each { |h| @parse_data.push(h)}
    @data = []
  end


private

  def create_input_vectors(training_data, determination)
    training_data.map { |headline| create_input_hash(headline, determination) }
  end

  def create_input_hash(headline, determination)
    {
      vector: [MULTIPLIER,
               first_word(headline),
               key_words(headline) + number_occurrences(headline),
               key_phrases(headline)],
      expected: determination
    }
  end

  def first_word(headline)
    starting_pronouns.inject(0) { |r, w| p headline.first; headline.first.split(" ")[0].to_i != 0 && r == 0 || headline.first.split(' ')[0] == w ? r + 1 : r }
  end

  def key_words(headline)
    @key_words.inject(0) { |r, word| headline.first.downcase.include?(word) ? r + 1 : r }
  end

  def key_phrases(headline)
    @key_phrases.inject(0) { |r, phrase| headline.first.downcase.include?(phrase) ? r + 1 : r }
  end

  def number_occurrences(headline)
    headline.first.scan(/\d+/).count
  end
end
