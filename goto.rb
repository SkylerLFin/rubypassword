require 'goto'

frame_start

label(:a) do
  puts "a"
end

label(:b) do
  puts "b"
  goto :a if rand > 0.1
end

frame_end