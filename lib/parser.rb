class Parser

MULTIPLIER = 1

attr_reader :data, :parse_data

  def initialize
    @data = []
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
      vector: [MULTIPLIER, word_count(headline)],
      expected: determination
    }
  end

  def word_count(headline)
    headline.first.split(' ').length
  end
end
