input, missed, word = "", 0, ["foobar", "schrumpfschniepel", "saftsack", "wir lieben awe"][rand(4)]
begin
	puts word.gsub(/[^ #{input}]{1}/i, "_") + " (" + (input.size==0 || word.include?(input[input.size-1]) ? missed.to_s + " Fehler)" : (missed += 1).to_s + " Fehler)\nBisherige Eingabe: " + input)
	(missed == 10) ? (puts "Zu viele Fehler!") : (input += (gets or return)[0])
end while (missed < 10 && word.gsub(/[^ #{input}]/i, "_") != word)
word.gsub(/[^ #{input}]{1}/i, "_") != word or puts "Geschafft:\n" + word
