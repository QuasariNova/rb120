class Prompt
  attr_reader :result

  def initialize(chos, prmpt = nil, err = nil)
    self.choices = chos.map &:downcase
    self.error = err ? err : "Sorry, invalid choice."
    self.prompt_message = prmpt ? prmpt : choices_to_string
  end

  def ask
    answer = ''

    loop do
      puts prompt_message
      print_prompt
      answer = possible_choices gets.chomp.downcase

      answer = verify_choice answer
      break if answer

      puts error
    end

    self.result = answer
  end

  private

  attr_accessor :choices, :error, :prompt_message
  attr_writer :result

  def possible_choices(input)
    choices.select { |choice| choice.start_with? input }
  end

  def verify_choice(options)
    return nil if options.empty?
    return options[0] if options.one?

    print_options options

    loop do
      print_prompt

      index = gets.to_i - 1
      return options[index] if index >= 0 # if none will return nil

      puts "Please enter a number from 1-#{options.size}"
    end
  end

  def print_options(options)
    options = options + ['None of the above']
    puts "Did you mean? (1-#{options.size})"

    options.each_with_index do |option, index|
      puts "#{index + 1} #{option.capitalize}"
    end
  end

  def print_prompt
    print "=> "
  end

  def choices_to_string
    case choices.size
    when 1 then choices[0] + ':'
    when 2 then "#{choices[0]} or #{choices[1]}:"
    else "#{choices[0...-1].join(', ')}, or #{choices[-1]}:"
    end
  end
end

class Move
  VALUES = %w(rock paper scissors spock lizard).freeze
  include Comparable

  def initialize(value)
    @value = VALUES.index value
  end

  # Choice| Other | Dif | % 3 | % 5 | | Choice| Other | Dif | % 3 | % 5 |
  # rock  | rock  |  0  | 0 t | 0 t |
  # rock  | paper*| -1  | 2 l | 4 l | |*paper | rock  |  1  | 1 w | 1 w |
  # rock* | sciss | -2  | 1 w | 3 w | | sciss |*rock  |  2  | 2 l | 2 l |
  # rock  | spock*| -3  | n\a | 2 l | |*spock | rock  |  3  | n/a | 3 w |
  # rock* | lizar | -4  | n\a | 1 w | | lizar |*rock  |  4  | n/a | 4 l |
  # paper | paper |  0  | 0 t | 0 t |
  # paper | sciss*| -1  | 2 l | 4 l | |*sciss | paper |  1  | 1 w | 1 w |
  # paper*| spock | -2  | n\a | 3 w | | spock |*paper |  2  | n\a | 2 l |
  # paper | lizar*| -3  | n\a | 2 l | |*lizar | paper |  3  | n\a | 3 w |
  # sciss | sciss |  0  | n\a | 0 t |
  # sciss | spock*| -1  | n\a | 4 l | |*spock | sciss |  1  | n\a | 1 w |
  # sciss*| lizar | -2  | n\a | 3 w | | lizar | sciss |  2  | n\a | 2 l |
  # spock | spock |  0  | n\a | 0 t |
  # spock | lizar*| -1  | n\a | 4 l | |*lizar | spock |  1  | n\a | 1 w |
  # lizar | lizar |  0  | n\a | 0 t |
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
  attr_reader :move, :name

  def initialize
    set_name
  end

  private

  attr_writer :move, :name
end

class Human < Player
  def choose
    prompt = Prompt.new Move::VALUES, "Rock, Paper, Scissors, Lizard, or Spock:"
    prompt.ask
    self.move = Move.new prompt.result
  end

  private

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
end

# Computer is your basic cpu. It just chooses a move at random
class Computer < Player
  def initialize
    super
    self.pref = Move::VALUES
  end

  def choose
    self.move = Move.new pref.sample
  end

  private

  def set_name
    self.name = 'Computer'
  end

  attr_accessor :pref
end

# Hal chooses each choice in sequence.
class HAL < Computer
  def initialize
    super
    self.idx = 0
  end

  def choose
    self.move = Move.new pref[idx % pref.size]
    change_index
  end

  private

  def set_name
    self.name = 'HAL 9000'
  end

  def change_index
    self.idx += 1
  end

  attr_accessor :idx
end

# Femputer chooses each choice in reverse sequence.
class Femputer < HAL
  private

  def set_name
    self.name = 'Femputer'
  end

  def change_index
    self.idx -= 1
  end
end

# DeepBlue has a sequence that is a bit tricky to see.
class DeepBlue < HAL
  def initialize
    super
    self.pref = %w(spock paper lizard scissors rock paper scissors spock lizard
                   rock)
  end

  private

  def set_name
    self.name = 'Deep Blue'
  end
end

# Warbot only has weapons at his disposal. If only he had hands.
class Warbot < Computer
  def initialize
    super
    self.pref = %w(rock rock rock rock rock scissors scissors scissors scissors)
  end

  private

  def set_name
    self.name = 'Warbot CPA'
  end
end

# BMO doesn't like weapons.
class BMO < Computer
  def initialize
    super
    self.pref = %w(paper paper paper paper spock spock spock lizard lizard)
  end

  private

  def set_name
    self.name = 'BMO'
  end
end

# WallE found a rock.
class WallE < Computer
  def choose
    self.move = Move.new 'rock'
  end

  private

  def set_name
    self.name = 'Wall-E'
  end
end

# C3PO does not like rocks as they can hurt him.
class C3P0 < Computer
  def initialize
    super
    self.pref = %w(paper paper paper scissors scissors spock spock spock lizard)
  end

  private

  def set_name
    self.name = 'C3P0'
  end
end

# Game Orchestration Engine
class RPSGame
  AI = [Computer, HAL, Warbot, BMO, WallE, Femputer, DeepBlue, C3P0].freeze

  def initialize
    @human = Human.new
    @computer = AI.sample.new
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

  private

  attr_accessor :human, :computer

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
    prompt = Prompt.new %w(yes no), "Would you like to play again? (Yes or No)"
    prompt.ask

    prompt.result == 'yes'
  end
end

RPSGame.new.play
