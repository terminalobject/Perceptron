require 'perceptron'

describe Perceptron do
  let(:weight)         { double('weight', vector: Vector[-1, 0])}
  let(:input_vector)          { double('input', vector: Vector[2, 2])}
  let(:hash)                  { { vector: Vector[1, 1], expected: 0 } }
  let(:hash_with_discrepancy) { { vector: Vector[1, 1], expected: 1 } }
  subject(:perceptron)        { described_class.new(1, weight) }

  describe "#predict" do
    it "compares the scalar_product with 0" do
      allow(weight).to receive(:inner_product)
        .with(input_vector)
        .and_return(2)
      allow(input_vector).to receive(:size).and_return(2)
      allow(input_vector).to receive(:[]).with(0)
      expect(perceptron.predict(input_vector.vector)).to eq 0
    end
  end

  describe "#train" do
    context "when prediction is not equal to expectation" do
      it "calls learn" do
        expect(perceptron).to receive(:learn)
        allow(weight).to receive(:update).with([-2, -1])
        perceptron.train(hash_with_discrepancy)
      end
    end

    context "when prediction equals expectation" do
      it "does not call learn" do
        expect(perceptron).to_not receive(:learn)
        perceptron.train(hash)
      end
    end
  end
end
