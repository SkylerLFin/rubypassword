require "rubygems"

require 'conceal'
ciphered = ""
puts 'key'
keys = gets.chomp()


File.open("encrypted.txt", 'r') do |file|
  ciphered = file.read()
end
decrypted = Conceal.decrypt(ciphered, key: keys)
puts decrypted


puts ""
puts ""
puts ""
puts ""

nxt_line = "\n"
puts "enter website for new password"
add_website = ""
add_website = gets.chomp()


puts "enter password for " + add_website
add_password = ""
add_password = gets.chomp()


format = add_website + " => " + add_password
puts ""
puts ""
puts ""
puts ""

addition = nxt_line + format
new_text = decrypted + addition
puts new_text

encrypted = ""
encrypted = Conceal.encrypt(new_text,key: keys,algorithm: 'aes-256-cbc')

File.open("encrypted.txt", 'w') do |file|
  encrypted = file.write(encrypted)
end
