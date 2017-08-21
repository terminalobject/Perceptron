class Histogram

attr_reader :data, :hash

  def initialize
    @data = []
    @hash = Hash.new(0)
  end

  def load_file(file)
    File.foreach(file) { |line| @data << line.split("\n") }
  end

  def create_histogram
    @data.join.split.each { |word| @hash[word] += 1}
  end

end
