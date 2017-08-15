frequencies = Hash.new(0)
arr = File.foreach('reuters.txt').map { |line| line.split('\n') }

arr2 = arr.each do |array|
  array.each do |sentence|
    sentence.split.each {|word|
      if word.to_i != 0
        if sentence.split.first == word
          word.gsub!(word, "first-number")
        else
          word.gsub!(word, "number")
        end
      end
        frequencies[word] += 1}

  end
end


frequencies = frequencies.sort_by {|k,v| v}.reverse
print frequencies[0..50]
