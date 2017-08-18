require 'matrix'

class Weight
  attr_reader :vector

  INITIAL_BIAS = -3

  def initialize(features_number)
    @values = Array.new(features_number) { rand(0.0..1.0).round(2)}
    @vector = vector_init(@values)
  end

  def update(values)
    @vector = Vector[*values]
  end

  private

  def vector_init(array)
    prepend_bias(array)
    Vector[*array]
  end

  def prepend_bias(array)
    array.unshift(INITIAL_BIAS)
  end
end
