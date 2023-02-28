class Move
  VALUES = ['rock', 'paper', 'scissors', 'spock', 'lizard']
  include Comparable

  def initialize(value)
    @value = VALUES.index(value)
  end

  # Choice| Other | Dif | % 3 | % 5 | | Choice| Other | Dif | % 3 | % 5 |
  # rock  | rock  |  0  |  0  |  0t |
  # rock  | paper*| -1  |  2  |  4l | |*paper | rock  |  1  |  1  |  1w |
  # rock* | sciss | -2  |  1  |  3w | | sciss |*rock  |  2  |  2  |  2l |
  # rock  | spock*| -3  | n\a |  2l | |*spock | rock  |  3  | n/a |  3w |
  # rock* | lizar | -4  | n\a |  1w | | lizar |*rock  |  4  | n/a |  4l |
  # paper | paper |  0  |  0  |  0t |
  # paper | sciss*| -1  |  2  |  4l | |*sciss | paper |  1  |  1  |  1w |
  # paper*| spock | -2  | n\a |  3w | | spock |*paper |  2  | n\a |  2l |
  # paper | lizar*| -3  | n\a |  2l | |*lizar | paper |  3  | n\a |  3w |
  # sciss | sciss |  0  | n\a |  0t |
  # sciss | spock*| -1  | n\a |  4l | |*spock | sciss |  1  | n\a |  1w |
  # sciss*| lizar | -2  | n\a |  3w | | lizar | sciss |  2  | n\a |  2l |
  # spock | spock |  0  | n\a |  0t |
  # spock | lizar*| -1  | n\a |  4l | |*lizar | spock |  1  | n\a |  1w |
  # lizar | lizar |  0  | n\a |  0w |
  # The <=> method subtracts the objects move index by others move index. It
  # then takes that value modulo the number of choices. 0 is tie, odd is win,
  # and even is loss. If you look at the chart above, this is true of both
  # rock paper scissors and rock paper scissors lizard spock. It could also
  # be true of some other odd > 3 choices, though as we get higher, not all
  # versions of this would be true. If spock was a different option that say
  # beat paper and rock, while lizard beat scissors and spock, this wouldn't be
  # a possible way to check.
  def <=>(other)
    value_dif = value - other.value
    return 0 if value_dif.zero?
    return 1 if (value_dif % VALUES.length).odd?
    -1
  end

  def to_s
    VALUES[value].capitalize
  end

  protected

  attr_reader :value
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ""

    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end

    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose Rock, Paper, Scissors, Lizard, or Spock:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end

    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie"
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry, must be y or n"
    end

    answer.downcase == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
