require_relative 'weight'
require 'matrix'

class Perceptron
  attr_reader :weight_vector, :parser

  EPOCHS = 1000

  def initialize(weight = Weight.new, parser = Parser.new)
    @weight_vector = weight
    @parser = parser
  end

  def scalar_product(vector)
    @weight_vector.vector.inner_product vector
  end

  def predict(vector)
    scalar_product(vector) > 0 ? 1 : 0
  end

  def calculate_error(hash)
    hash[:expected] - predict(Vector[*hash[:vector]])
  end

  def compare(hash)
    learn(hash) unless calculate_error(hash).zero?
  end

  def learn(hash)
    @weight_vector.update(updated_weight_arr(hash))
  end

  def updated_weight_arr(hash)
    (@weight_vector.vector + Vector[*hash[:vector]] * calculate_error(hash)).to_a
  end

  def training
    EPOCHS.times { @parser.parse_data.each { |hash| print learn(hash) } }
  end
end
