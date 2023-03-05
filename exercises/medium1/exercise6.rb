# Create an object-oriented number guessing class for numbers in the range 1 to
# 100, with a limit of 7 guesses per game. The game should play like this:

# game = GuessingGame.new
# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guess remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game with a new number to guess
# with each call to #play.

class GuessingGame
  RANGE = 1..100
  MAX_GUESSES = 7

  def play
    reset
    loop do
      display_guess_status
      ask_for_number
      display_hint
      decrease_guesses
      break if is_number? || out_of_turns?
    end
    display_result
  end

  private

  attr_accessor :secret_number, :guesses, :guess

  def reset
    self.secret_number = RANGE.to_a.sample
    self.guesses = MAX_GUESSES
  end

  def display_guess_status
    if guesses == 1
      puts "You have #{guesses} guess remaining."
    else
      puts "You have #{guesses} guesses remaining."
    end
  end

  def ask_for_number
    input = nil
    loop do
      print "Enter a number between 1 and 100: "
      input = gets.chomp.to_i
      break if RANGE.include? input
      print "Invalid guess. "
    end
    self.guess = input
  end

  def display_hint
    num = guess
    puts 'Your guess is too low.' if num < secret_number
    puts 'Your guess is too high.' if num > secret_number
    puts 'That is the number.' if num == secret_number
    puts nil
  end

  def display_result
    if guess == secret_number
      puts "You won!"
    else
      puts "You have no more guesses. You lost!"
    end
  end

  def decrease_guesses
    self.guesses -= 1
  end

  def out_of_turns?
    guesses <= 0
  end

  def is_number?
    secret_number == guess
  end
end
