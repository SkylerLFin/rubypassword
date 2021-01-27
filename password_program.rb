require "rubygems"

require 'conceal'
require 'goto'

frame_start

file_name = ""
existence = 0
contents = ""
afterwards = ""
website = ""
password = ""
working_string = ""
keys = ""
ciphered = ""
list = ""

label(:a) do
  puts "Enter the name of the file you want to create or open.(Capitalization Matters)"
  file_name = gets.chomp()
end

label(:b) do
  File.open("accounts.txt", "r") do |file|
    for line in file.readlines()
      if line == file_name || line == file_name + "\n"
        existence = 1
        break
      else
        existence = 0
      end
    end
    list = file.read()
  end
  goto :keys if existence == 1
  goto :e if existence == 0
end


label (:keys) do
  puts "Please enter the password for this file."
  keys = gets.chomp()
  goto :c
end

label (:c) do
  if afterwards == 'back'
    encrypted = Conceal.encrypt(working_string,key: keys, algorithm: 'aes-256-cbc')
    File.open(file_name + ".txt", "w") do |file|
      file.write(encrypted)
    end
  end
  puts ""
  puts ""
  puts ""
  File.open(file_name + ".txt", "r") do |file|
    ciphered = file.read()
  end
  
  begin
    contents = Conceal.decrypt(ciphered,key: keys)
  rescue ArgumentError
    puts "Sorry, if you would like to try to open another file enter 'diff' otherwise enter 'retry' or 'close' to exit"
    afterwards = gets.chomp()
    goto :a if afterwards == 'diff'
    goto :keys if afterwards == 'retry'
    goto :z if afterwards == 'close'
    goto :c
  end
  puts contents
  puts "To add a line type 'add' or to close the file type 'close' to open a different file type 'restart'"
  afterwards = gets.chomp()
  goto :a if afterwards == 'restart'
  goto :z if afterwards == 'close'
  goto :d if afterwards == 'add'
  goto :c
end

label (:d) do
  puts "please enter the name of the website you wish to add."
  website = gets.chomp()
  puts "please enter the password to " + website
  password = gets.chomp()
  working_string = contents + website + " => " + password + "\n"
  contents = working_string
  puts "to add another line enter 'add' or type 'back' to return"
  afterwards = gets.chomp()
  goto :c if afterwards == 'back'
  goto :d if afterwards == 'add'
  goto :c
end

label (:e) do
  puts "This file does not exist. If this is a mistake enter 'retry' to create the file enter 'create' or to close enter 'close'"
  afterwards = gets.chomp()

  goto :z if afterwards == 'close'
  goto :a if afterwards == 'retry'
  goto :f if afterwards == 'create'
  
  goto :e
end

label (:f) do
  File.open(file_name + ".txt", "w") do |file|
    file.write(file_name + "\n")
  end
  File.open(file_name + ".txt", "r") do |file|
    contents = file.read()
  end
  puts "please enter the password which you will encrypt this file with.  You will have to verify by entering the key again.(ensure this password is recorded and stored safely)"
  keys = gets.chomp()
  encrypted = Conceal.encrypt(contents,key: keys, algorithm: 'aes-256-cbc')
  File.open(file_name + ".txt", "w") do |file|
    file.write(encrypted)
  end
  File.open("accounts.txt", "a") do |file|
    file.write(list + file_name + "\n")
  end
  goto :c
end


label (:z) do
  return
end


frame_end