require_relative '../../lib/parser'

class Sanitiser

  attr_reader :data, :parser, :zipped_data, :counter, :output_data

  def initialize(parser = Parser.new)
    @data = []
    @counter = 0
    @parser = parser
    @zipped_data = []
    @output_data = []
  end

 def load(file)
   File.foreach(file) { |line| @data << line.downcase.split("\n") }
  #  parser.load_file(file)
  #  @data = parser.data
 end

 def parse_data(determination)
   parser.parse(determination)
 end

  def zipping
    @zipped_data = data.zip(parser.parse_data)
  end

  def clean_data
    @data.each do |headline|
      vector = parser.parse_individual(:good, headline)
      if vector[:vector][1..3].reduce(:+) > 1
        @bad_file.puts headline
      else
        @good_file.puts headline
        p "test"
      end

      @counter += 1
    end

    @data = []
  end

  def clean
   zipped_data.each do |x|
     if (x.last[:vector][1..3].reduce(:+) > 1)
       zipped_data.delete_at(zipped_data.index(x))
       @counter += 1
     end
   end
 end

 def create_output_file
   @good_file = File.new('scraper/training_data/good.txt', 'a')
   @bad_file = File.new('scraper/training_data/bad.txt', 'a')
 end

 def create_output
    File.open('scraper/training_data/good_from_bad.txt', 'w') do |file|
      zipped_data.each { |x| file << x.first.join + "\n"}
    end
  end

end
