require 'weight'

describe Weight do
  let(:updated_values) { [1, 1, 1] }
  subject(:weight)     { described_class.new(3) }

  describe "Initialisation" do
    it "creates a vector of n+1 size" do
      expect(weight.vector.size).to eq 4
    end

    it "generates BIAS value" do
      expect(weight.vector[0]).to eq Weight::INITIAL_BIAS
    end
  end

  describe "#update" do
    it "updates the vector" do
      weight.update(updated_values)
      expect(weight.vector).to eq(Vector[1, 1, 1])
    end
  end
end
