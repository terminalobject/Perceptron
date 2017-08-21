require 'matrix'
require_relative 'weight'

class PocketPerceptron

  def initialize(features_number, weight = Weight.new(features_number))
    @weight = weight
    @temp_weight = weight
  end

  def predict(vector)
    scalar_product(@weight.vector, vector) > 0 ? 1 : 0
  end

  def predict_temp(vector)
    scalar_product(@temp_weight.vector, vector) > 0 ? 1 : 0
  end

  def train(array)
    array.each do |hash|
      if calculate_error(hash, predict_temp(hash[:vector])).zero?
        @temp_weight.correct_run += 1
        if @temp_weight.correct_run > @weight.correct_run
          if num_ok(array, predict_temp) > num_ok(array, predict)
            @weight = @temp_weight
            @weight.correct_run = @temp_weight.correct_run
            @weight.correct_total = @temp_weight.correct_total
            if @weight.correct_run = array.length
              break
            end
          end
        end
      else
        learn(hash)
        @weight.correct_run = 0
      end
    end
  end

  private

  def scalar_product(vector_1, vector_2)
    vector_1.inner_product vector_2
  end

  def calculate_error(hash, type)
    hash[:expected] - type(Vector[*hash[:vector]])
  end

  def learn(hash)
    @temp_weight.update(updated_weight_arr(hash))
  end

  def num_ok(array, type)
    if type = predict
      @weight.correct_total = array.map{ |element| calculate_error(element, type) }.count(0)
    else type = predict_temp
      @temp_weight.correct_total = array.map{ |element| calculate_error(element, type) }.count(0)
    end
  end

  def updated_weight_arr(hash)
    (@weight.vector + Vector[*hash[:vector]] * calculate_error(hash)).to_a
  end
end
