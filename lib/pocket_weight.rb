require 'matrix'

class PocketWeight
  attr_reader :vector

  INITIAL_BIAS = 0 

  def initialize(features_number)
    @values = Array.new(features_number, 0)
    @vector = vector_init(@values)
    @correct_run = 0
    @correct_total = 0
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
