require 'parser'

describe Parser do

  subject(:parser)  { described_class.new }
  let(:headline1) { '17 Times "Gogglebox" Was Out Of Control Sassy' }
  let(:headline2) { 'People Are Mocking White Nationalists For Marching With Literal Tiki Torches' }
  let(:training_data) { [headline1, headline2] }
  let(:input_vector) { [{multiplier: 1, word_count: 8}, {multiplier: 1, word_count: 11}] }

  describe '#create_input_vectors' do
    it 'returns an array of input vectors' do
      expect(parser.create_input_vectors(training_data)).to eq input_vector
    end
  end

end
