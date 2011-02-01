#!/usr/bin/ruby
i, w, c, aW, f = [], proc {|s| s[rand(s.size)] }.call(["letmein", "hello world"]), proc { |w,c| c.size - w.split(//).uniq.join.count(c.join) }, proc { |w,c| w.gsub(/[^#{c.join.empty? ? "." : c.join}\s]/, '_') }, true
begin
  print(aW.call(w, i),"  (", c.call(w, i), " bad tries)\n", ((f=(aW.call(w, i) != w)) ? "" : "geschafft\n"))  
end while (c.call(w, i) < 10 && f && (i=(i+((t=(gets or break).strip[0]) != nil ? t.split(//) : []))))