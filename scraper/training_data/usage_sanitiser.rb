
  source_files = {'scraper/training_data/raw/buzzfeed.txt' => :bad,   'scraper/training_data/raw/collegehumor.txt' => :bad, 'scraper/training_data/raw/cosmopolitan.txt' => :bad, 'scraper/training_data/raw/cracked.txt' => :bad,
  'scraper/training_data/raw/guardian.txt' => :good, 'scraper/training_data/raw/reuters.txt'=> :good, 'scraper/training_data/raw/telegraph.txt'=> :good }
  source_files.each do |key, value|
    if value == :good
      p.load_file(key)
      p.parse(:good)
    else
      p.load_file(key)
      p.parse(:bad)
    end
  end
    # s.load('scraper/training_data/raw/reuters.txt')
    # s.parser.parse(:good)

s.zipping
s.clean_data
