# In the previous exercise, you wrote a number guessing game that determines a
# secret number between 1 and 100, and gives the user 7 opportunities to guess
# the number.

# Update your solution to accept a low and high value when you create a
# GuessingGame object, and use those values to compute a secret number for the
# game. You should also change the number of guesses allowed so the user can
# always win if she uses a good strategy. You can compute the number of guesses
# with:

# Math.log2(size_of_range).to_i + 1

# Examples:

# game = GuessingGame.new(501, 1500)
# game.play

# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 104
# Invalid guess. Enter a number between 501 and 1500: 1000
# Your guess is too low.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 1250
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 1375
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 80
# Invalid guess. Enter a number between 501 and 1500: 1312
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 1343
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 1359
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 1351
# Your guess is too high.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 1355
# That's the number!

# You won!

# game.play
# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 1000
# Your guess is too high.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 750
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 875
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 812
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 843
# Your guess is too high.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 820
# Your guess is too low.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 830
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 835
# Your guess is too low.

# You have 2 guesses remaining.
# Enter a number between 501 and 1500: 836
# Your guess is too low.

# You have 1 guess remaining.
# Enter a number between 501 and 1500: 837
# Your guess is too low.

# You have no more guesses. You lost!

# Note that a game object should start a new game with a new number to guess with each call to #play.

class GuessingGame
  def initialize(low, high)
    @range = low..high
    @secret_number = nil
    @guesses = nil
    @guess = nil
  end

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

  attr_reader :range
  attr_accessor :secret_number, :guesses, :guess

  def reset
    self.secret_number = range.to_a.sample
    self.guesses = Math.log2(range.size).to_i + 1
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
      print "Enter a number between #{range.first} and #{range.last}: "
      input = gets.chomp.to_i
      break if range.include? input
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

game = GuessingGame.new(501, 1500)
game.play
