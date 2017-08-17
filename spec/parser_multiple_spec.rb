require 'parser_multiple'

describe ParserMultiple do
  let(:file_path) { File.expand_path(File.dirname(__FILE__)) }

  describe '#parse' do
    context 'Inputs considered bad' do
      subject(:parser_multiple) { described_class.new("#{file_path}/fixtures/bad_data.txt") }

      let(:first_output)  { { vector: [1, 8, 1, 2], expected: 1 } }
      let(:second_output) { { vector: [1, 12, 1, 3], expected: 1 } }
      let(:output)        { [first_output, second_output] }

      it 'returns a hash of input vectors' do
        expect(parser_multiple.parse(:bad)).to eq output
      end
    end

    context 'Inputs considered good' do
      subject(:parser_multiple) { described_class.new("#{file_path}/fixtures/good_data.txt") }

      let(:first_output)  { { vector: [1, 12, 0, 0], expected: 0 } }
      let(:second_output) { { vector: [1, 8, 0, 0], expected: 0 } }
      let(:output)        { [first_output, second_output] }

      it 'returns a hash of input vectors' do
        expect(parser_multiple.parse(:good)).to eq output
      end
    end
  end
end
