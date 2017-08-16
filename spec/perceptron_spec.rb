require 'perceptron'

describe Perceptron do
  let(:vector_a) { Vector[1,0] }
  let(:vector_b) { Vector[1,1] }
  let(:weight_vector)  { double('weight', vector: Vector[-1, 0])}
  let(:input_vector)   { double('input', vector: Vector[2, 2])}
  let(:hash)           { { vector: Vector[1, 1], expected: 0 } }
  let(:hash_with_discrepancy)           { { vector: Vector[1, 1], expected: 1 } }
  subject(:perceptron) { described_class.new(weight_vector) }

  describe "#scalar_product" do
    it "evaluates scalar product of two vectors" do
      allow(input_vector).to receive(:size).and_return(2)
      allow(input_vector).to receive(:[]).with(0)
      expect(weight_vector.vector).to receive(:inner_product).with(input_vector)
      perceptron.scalar_product(input_vector)
    end
  end

  describe "#predict" do
    it "compares the scalar_product with 0" do
      allow(weight_vector).to receive(:inner_product)
        .with(input_vector)
        .and_return(2)
      allow(input_vector).to receive(:size).and_return(2)
      allow(input_vector).to receive(:[]).with(0)
      expect(perceptron.predict(input_vector.vector)).to eq 0
    end
  end

  describe "#calculate_error" do
    it "calculates discrepancy between prediction and expectation" do
      expect(perceptron.calculate_error(hash)).to eq 0
    end 
  end 

  describe "#updated_weight_arr" do
    context "when discrepancy is zero" do
      it "determines how to update the weight vector" do
        expect(perceptron.updated_weight_arr(hash)).to eq([-1, 0])
      end
    end
    context "when discrepancy is not zero" do
      it "determines how to update the weight vector" do
        expect(perceptron.updated_weight_arr(hash_with_discrepancy)).to eq([0,1]) 
      end 
    end
  end 
  describe "#compare" do
    context "when prediction is not equal to expectation" do
      it "calls learn" do
        expect(perceptron).to receive(:learn)
        allow(weight_vector).to receive(:update).with([-2, -1])
        perceptron.compare(hash_with_discrepancy)
      end
    end
    context "when prediction equals expectation" do
      it "does not call learn" do
        expect(perceptron).to_not receive(:learn)
        perceptron.compare(hash)
      end 
    end
  end 
  describe  "#learn" do
    it "triggers weight vector upgrade" do
      expect(weight_vector).to receive(:update)
      perceptron.learn(hash_with_discrepancy)
    end 
  end 
end
