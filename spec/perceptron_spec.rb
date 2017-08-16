require 'perceptron'

describe Perceptron do
  let(:weight_vector)  { double('weight', vector: Vector[1, 0])}
  let(:input_vector)   { double('input', vector: Vector[2, 2])}
  let(:hash)           { { vector: [1, 1], expected: 0 } }
  subject(:perceptron) { described_class.new(weight_vector) }

  describe "#scalar_product" do
    it "evaluates scalar product of two vectors" do
      expect(weight_vector).to receive(:inner_product).with(input_vector)
      perceptron.scalar_product(input_vector)
    end
  end

  describe "#predict" do
    it "compares the scalar_product with 0" do
      allow(weight_vector).to receive(:inner_product)
        .with(input_vector)
        .and_return(2)
      expect(perceptron.predict(input_vector)).to eq  1
    end
  end

  describe "#compare" do
    context "when prediction is not equal to expectation" do
      it "calls learn" do
        expect(weight_vector).to receive(:inner_product).twice.and_return(2)
        expect(weight_vector).to receive(:learn)
        perceptron.compare(hash)
      end
    end
  end
end
