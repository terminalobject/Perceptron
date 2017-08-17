require 'matrix'
class Weight
  attr_reader :vector
  INITIAL_BIAS = -3

  def initialize(array)
    @values = array
    @vector = vector_init(array)
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
