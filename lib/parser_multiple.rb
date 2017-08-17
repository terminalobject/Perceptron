class ParserMultiple

MULTIPLIER = 1

  attr_reader :data, :starting_pronouns

  def initialize(file)
    @data = File.foreach(file).map { |line| line.split("\n") }
    @starting_pronouns = ["He", "She", "I", "It", "You", "My", "It's", "They", "They'll", "He'll", "She'll", "You'll"]
  end

  def parse(determination)
    create_input_vectors(@data, determination == :good ? 0 : 1)
  end

private

  def create_input_vectors(training_data, determination)
    training_data.map { |headline| create_input_hash(headline, determination) }
  end

  def create_input_hash(headline, determination)
    {
      vector: [MULTIPLIER,
               word_count(headline),
               number_first_position(headline),
               flagged_pronoun_first_position(headline)],
      expected: determination
    }
  end

  def word_count(headline)
    headline.first.split(' ').length
  end

  def number_first_position(headline)
    headline.first.split(' ')[0].to_i != 0 ? 1 : 0
  end

  def flagged_pronoun_first_position(headline)
    starting_pronouns.inject(0) { |r, w| w == headline.first.split(' ')[0] ? r + 1 : r }
  end

end
