require 'io/console'

puts "Ruby REPL"

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
  repl[">> "]
end

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char

  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end

  ensure
  STDIN.cooked!
  
  return input

end

def show_single_key
  c = read_char
  return c.inspect
end
