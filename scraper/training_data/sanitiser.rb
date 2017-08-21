require_relative '../../lib/parser'

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

  def clean_data
    create_output_files
    @data.each do |headline|
      vector = parser.parse_individual(:good, headline)
      if vector[:vector][1..5].reduce(:+) >= 2
        p "BAD: #{vector[:vector]} || #{headline}"
        @bad_file.puts headline
      else
        # p "GOOD: #{vector[:vector]} || #{headline}"
        @good_file.puts headline
      end
      @counter += 1
    end

    @data = []
    close_output_files
  end


  def create_output_files
    @good_file = File.new('scraper/training_data/new_good.txt', 'a')
    @bad_file = File.new('scraper/training_data/new_bad.txt', 'a')
  end

  # def open_output_files
  #   @good_file.open
  #   @bad_file.open
  # end

  def close_output_files
    @good_file.close
    @bad_file.close
  end

 # def create_output
 #    File.open('scraper/training_data/good_from_bad.txt', 'w') do |file|
 #      zipped_data.each { |x| file << x.first.join + "\n"}
 #    end
 #  end

  #  def clean
  #   zipped_data.each do |x|
  #     if (x.last[:vector][1..3].reduce(:+) > 1)
  #       zipped_data.delete_at(zipped_data.index(x))
  #       @counter += 1
  #     end
  #   end
  # end
end
