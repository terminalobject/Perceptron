require 'json'
require 'parser'

describe Parser do
  let(:file_path) { File.expand_path(File.dirname(__FILE__)) }

  describe '#parse' do
    context 'Inputs considered bad' do
      subject(:parser) { described_class.new("#{file_path}/fixtures/bad_data.txt") }

      let(:first_output)  { { vector: [1, 8], expected: 1 } }
      let(:second_output) { { vector: [1, 11], expected: 1 } }
      let(:output)        { [first_output, second_output] }

      it 'returns a hash of input vectors' do
        expect(parser.parse(:bad)).to eq output
      end
    end

    context 'Inputs considered good' do
      subject(:parser) { described_class.new("#{file_path}/fixtures/good_data.txt") }

      let(:first_output)  { { vector: [1, 12], expected: 0 } }
      let(:second_output) { { vector: [1, 8], expected: 0 } }
      let(:output)        { [first_output, second_output] }

      it 'returns a hash of input vectors' do
        expect(parser.parse(:good)).to eq output
      end
    end
  end
end
