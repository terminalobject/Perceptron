class ParserMultiple

MULTIPLIER = 1

  def initialize(file)
    @data = File.foreach(file).map { |line| line.split("\n") }
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
      vector: [MULTIPLIER, word_count(headline), number_first_position(headline)],
      expected: determination
    }
  end

  def word_count(headline)
    headline.first.split(' ').length
  end

  def number_first_position(headline)
    headline.first.split(' ')[0].to_i != 0 ? 1 : 0
  end
end
