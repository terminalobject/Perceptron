require 'Perceptron'

describe Perceptron do
  
  subject(:perceptron) { described_class.new }
  let(:key_array) { ["w1", "w2", "w3"] }

  describe "#weight_vector_init" do
    it"creates a hash with n + 1 keys" do
      perceptron.weight_vector_init(key_array)
      p perceptron.weight_vector
      expect(perceptron.weight_vector.keys.length).to eq 4
    end 
    it "creates a BIAS key" do
      perceptron.weight_vector_init(key_array);
      expect(perceptron.weight_vector.keys[0]).to eq "BIAS" 
    end 
    it "generates BIAS value" do
      perceptron.weight_vector_init(key_array)
      expect(perceptron.weight_vector["BIAS"]).to eq Perceptron::BIAS 
    end 

    it "creates a key for each feature" do
      srand(1234)
      perceptron.weight_vector_init(key_array)
      expect(perceptron.weight_vector["w1"]).to eq 0.19151945027934003
    end 
  end 
end 
