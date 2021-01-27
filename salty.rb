require "rubygems"

require 'conceal'

passwords = "google = password1\nbing = password2"

puts 'enter key'
keys = gets.chomp()
ciphered = ""

encrypted = Conceal.encrypt(passwords,key: keys,algorithm: 'aes-256-cbc')
File.open("encrypted.txt", 'w') do |file|
  file.write(encrypted)
end