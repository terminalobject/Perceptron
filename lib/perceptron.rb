require 'matrix'
require_relative 'weight'

class Perceptron


  def initialize(features_number, weight = Weight.new(features_number))
    @weight = weight
  end

  def predict(vector)
    scalar_product(@weight.vector, vector) > 0 ? 1 : 0
  end

  def train(hash)
    learn(hash) unless calculate_error(hash).zero?
  end

  private

  def scalar_product(vector_1, vector_2)
    vector_1.inner_product vector_2
  end

  def calculate_error(hash)
    hash[:expected] - predict(Vector[*hash[:vector]])
  end

  def learn(hash)
    @weight.update(updated_weight_arr(hash))
  end

  def updated_weight_arr(hash)
    (@weight.vector + Vector[*hash[:vector]] * calculate_error(hash)).to_a
  end
end
