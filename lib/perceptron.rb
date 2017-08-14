class Perceptron

  attr_reader :weight_vector
  BIAS = 1

  def initialize()
    @weight_vector = {}  
  end 

  def weight_vector_init(keys_array)
    assign_bias_key
    keys_array.length.times{ |index| assign_feature_key(keys_array[index]) }
  end

  def assign_bias_key
    weight_vector["BIAS"] = BIAS
  end 

  def assign_feature_key(key)
    weight_vector[key] = rand(0.0..1.0)
  end 
end 
