class Parser

MULTIPLIER = 1

  attr_reader :data, :starting_pronouns, :parse_data

  def initialize
    @data = []
    @starting_pronouns = ["He", "She", "I", "It", "You", "My", "It's", "They", "They'll", "He'll", "She'll", "You'll"]
    @tracked_phrases = ["sex", "things", "number", "you'll", "these", "believe", "tips", "tweets", "never", "that will", "photos", "photo", "best", "make"]
  end

  def load_file(file)
    File.foreach(file) { |line| @data << line.split("\n") }
  end

  def parse(determination)
    @parse_data = create_input_vectors(@data, determination == :good ? 0 : 1)
  end


private

  def create_input_vectors(training_data, determination)
    training_data.map { |headline| create_input_hash(headline, determination) }
  end

  def create_input_hash(headline, determination)
    {
      vector: [MULTIPLIER,
               word_count(headline),
               first_word(headline),
               key_phrases(headline) + number_occurrences(headline)],
      expected: determination
    }
  end

  def word_count(headline)
    headline.first.split(' ').length
  end

  def first_word(headline)
    starting_pronouns.inject(0) { |r, w| headline.first.split(" ")[0].to_i != 0 && r == 0 || headline.first.split(' ')[0] == w ? r + 1 : r }
  end

  def key_phrases(headline)
    @tracked_phrases.inject(0) { |r, phrase| headline.first.downcase.include?(phrase) ? r + 1 : r }
  end
  def number_occurrences(headline)
    headline.first.scan(/\d+/).count
  end
end
