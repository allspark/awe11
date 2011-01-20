#!/usr/bin/ruby
c, word, count = [], proc {|s| s[rand(s.size)] }.call(["letmein", "hello world"]), proc { |w,c| w.split(//).uniq.join.count(c.join) }
begin
  print(word.gsub(/[^#{c.join.empty? ? "." : c.join}\s]/, '_'),"  (", c.size - count.call(word, c), " bad tries)\n")
  c=(c+((gets or break).strip[0] or next).split(//))
end while (c.size - count.call(word, c) < 10 && word.gsub(/[^#{c.join.empty? ? "." : c.join}\s]/, '_') != word)