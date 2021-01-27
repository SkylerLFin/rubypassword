require 'goto'

frame_start
ans = ""
label(:a) do
  puts "enter 1 or 2"
  ans = gets.chomp()
end

label(:b) do
  goto :a if ans == '1'
  goto :c if ans == '2'
end

label(:c) do
  puts"end"
  return
end

frame_end