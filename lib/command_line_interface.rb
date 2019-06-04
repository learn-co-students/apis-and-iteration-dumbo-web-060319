def welcome
  puts "Hello! Welcome to this Star Wars command line API"
end

def get_character_from_user
  puts "please enter a character name"
  # use gets to capture the user's input. This method should return that input, downcased.
  gets.chomp
end
