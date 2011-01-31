#!/usr/bin/ruby
inputCharactes = []
word = proc {|s| s[rand(s.size)] }.call(["letmein", "hello world"])
getTries = proc { |word,chars| chars.size - word.split(//).uniq.join.count(chars.join) }
actWort = proc { |word,chars| word.gsub(/[^#{chars.join.empty? ? "." : chars.join}\s]/, '_') }
guessing = true
max_bad_guesses=10
begin
  toGuess = actWort.call(word, inputCharactes)
  guessCount = getTries.call(word, inputCharactes)
  print(toGuess,"  (", guessCount, " bad tries)\n", ((guessing=(toGuess != word)) ? "" : "geschafft\n"))  
end while (guessCount < max_bad_guesses && guessing && (inputCharactes=(inputCharactes+((t=((gets) or break).strip[0]) != nil ? t.split(//) : []))))