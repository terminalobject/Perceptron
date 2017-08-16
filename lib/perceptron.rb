require_relative 'weight'
require 'matrix'

class Perceptron
  attr_reader :weight_vector

  def initialize(weight = Weight.new)
    @weight_vector = weight
  end

  def scalar_product(input_vector)
    weight_vector.inner_product input_vector
  end

  def predict(input_vector)
    scalar_product(input_vector) > 0 ? 1 : 0
  end

  def calculate_error(hash)
    hash[:expected] - predict(hash[:vector])
  end

  def compare(hash)
    @weight_vector.learn(calculate_error(hash)) unless calculate_error(hash).zero?
  end

  def learn(hash)
    @weight_vector.update(calculate_error(hash)) 
  end 
end
