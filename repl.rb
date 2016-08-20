require 'readline'

puts "Ruby REPL"

def readline_with_hist_management
  line = Readline.readline('>>', true)
  return nil if line.nil?
  if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
    Readline::HISTORY.pop
  end
  line
end


# Handle the input, this would probably run some method
# as a part of the DSL you'd have to create. Place this
# repl as your command line interface to your service.
def handle_input(input)
  result = eval(input)
  puts(" => #{result}")
end

# This is a lambda that runs the content of the block
# after the input is chomped.
repl = -> prompt do
  print prompt
  handle_input(gets.chomp!)
end

# After evaling and returning, fire up the prompt lambda
# again, this loops after every input and exits with
# exit or a HUP.
loop do
  readline_with_hist_management
  repl[">> "]
end
