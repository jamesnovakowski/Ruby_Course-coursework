
$charset = [" ","!",'"',"#","$","%","&","'","(",")","*","+",",","-",".","/",
	"0","1","2","3","4","5","6","7","8","9",":",";","<","=",">","?","@","A",
	"B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S",
	"T","U","V","W","X","Y","Z","[","]","^","_","'","a","b","c","d","e",
	"f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w",
	"x","y","z","{","|","}","~","¡","¢","£","¤","¥","¦","§","¨","©","ª","«",
	"¬","­","®","¯","°","±","²","³","´","µ","¶","•","¸","¹","º","»","¼","½",
	"¾","¿","À","Á","Â","Ã","Ä","Å","Æ","Ç","È","É","Ê","Ë","Ì","Í","Î","Ï",
	"Ð","Ñ","Ò","Ó","Ô","Õ","Ö","×","Ø","Ù","Ú","Û","Ü","Ý","Þ","ß","à","á",
	"â","ã","ä","å","æ","ç","è","é","ê","ë","ì","í","î","ï","ð","ñ","ò","ó",
	"ô","õ","ö","÷","ø","ù","ú","û","ü","ý","þ","ÿ","Œ","œ","Š","š","Ÿ","ƒ",
	"–","—","‘","’","‚","“","”","„","†","‡","•","…","‰","€","™"]

# charset exclusions: '\' because escapes.

def caesar_cypher (words, offset)

	new_charset = $charset.rotate(offset)

	words = words.split(" ")

	puts words

	new_words = Array.new()

	#break sentence into words
	words.each do |word|
		new_word = Array.new()

		#break words into letters, run cypther lookup on letters
		word.split("").each do |letter|
			char_index = $charset.index(letter)
			new_letter = new_charset[char_index]
			new_word.push(new_letter)
		end

		new_words.push(new_word.join"")
	end

	puts new_words.join(" ")
end

def decrypt ()
	puts "What phrase would you like decrypted?"
	phrase = gets.chomp

	puts "What is the cypher shift that was used to encode this phrase?"
	num = gets.chomp.to_i

	offset = -num
	caesar_cypher(phrase, offset)
end

def encrypt()
	puts "What phrase would you like encrypted?"
	phrase = gets.chomp()

	puts "What is the cypher shift you would like to use? (can be positive or negative"
	num = gets.chomp


# while (num.is_a? Integer)
# 	puts "Please enter a whole number"
# 	num = gets.chomp
# end

	num = num.to_i #Why do I get an error if I try to do "num.to_i! "?

	caesar_cypher(phrase, num)
end


puts "Would you like to encrypt (e) or decrypt (d) a phrase?"
action = gets.chomp.downcase

while action[0] != "d" && action[0] != "e"
	puts "I'm sorry, would you like to encrypt (e) or decrypt (d) a phrase?"
	action = gets.chomp.downcase
end

if action[0] == "e"
	encrypt()
else
	decrypt()
end







