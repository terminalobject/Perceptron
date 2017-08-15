class Parser

MULTIPLIER = 1

  def initialize
  end

  def create_input_vectors(training_data)
    training_data.map { |headline| create_input_vector(headline) }
  end

private

  def create_input_vector(headline)
    {
      multiplier: MULTIPLIER,
      word_count: word_count(headline)}
  end

  def feature_constructor(features)
   features.map { |feature| "#{feature}: #{feature}(headline)" }
  end

  def word_count(headline)
    headline.split(' ').length
  end

end
