require 'weight'

describe Weight do

  let(:values) { [0, 1, 1] }
  let(:updated_values) { [1, 1, 1] }
  subject(:weight) { described_class.new(values) }

  describe "#vector_init" do

    before do
      weight.vector_init(values)
    end

    it "creates a vector of n+1 size" do
      expect(weight.vector.size).to eq 4
    end

    it "generates BIAS value" do
      expect(weight.vector[0]).to eq Weight::BIAS
    end
  end

  describe "#update" do
    it "updates the vector" do
      weight.update(updated_values)
      expect(weight.vector).to eq(Vector[Weight::BIAS, 1,1,1])
    end
  end
end
