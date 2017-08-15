require 'matrix'
class Weight

  attr_reader :vector
  BIAS = 1

  def initialize(array)
    @values = array
    @vector = vector_init(array)
  end

  def vector_init(array)
    prepend_bias(array)
    Vector[*array]
  end

  def prepend_bias(array)
    array.unshift(BIAS)
  end

  def update(values)
    @vector = vector_init(values)
  end
end
