require_relative 'parser'

class Sanitiser
  attr_reader :data, :parser, :counter

  def initialize(parser = Parser.new)
    @data = []
    @counter = 0
    @parser = parser
  end

  def load(file)
    File.foreach(file) { |line| @data << line.downcase.split("\n") }
  end

  def zipping
    @zipped_data = data.zip(parser.parse_data)
  end

  def clean_data(determination)
    create_output_files
    @data.each do |headline|
      vector = parser.parse_individual(:determination, headline)
      if vector[:vector][1..5].reduce(:+) >= 2
        @bad_file.puts headline
      else
        @good_file.puts headline
      end
      @counter += 1
    end

    @data = []
    close_output_files
  end

  def create_output_files
    @good_file = File.new('scraper/training_data/sanitised_good.txt', 'a')
    @bad_file = File.new('scraper/training_data/sanitised_bad.txt', 'a')
  end

  def close_output_files
    @good_file.close
    @bad_file.close
  end
end
