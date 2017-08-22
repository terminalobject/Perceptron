require './lib/sanitiser.rb'
s = Sanitiser.new

  source_files = {'scraper/training_data/raw/buzzfeed.txt' => :bad,   'scraper/training_data/raw/collegehumor.txt' => :bad, 'scraper/training_data/raw/cosmopolitan.txt' => :bad, 'scraper/training_data/raw/cracked.txt' => :bad,
  'scraper/training_data/raw/guardian.txt' => :good, 'scraper/training_data/raw/reuters.txt'=> :good, 'scraper/training_data/raw/telegraph.txt'=> :good }
  source_files.each do |key, value|
    if value == :good
      s.load(key)
      s.clean_data(:good)
    else
      s.load(key)
      s.clean_data(:good)
    end
  end
