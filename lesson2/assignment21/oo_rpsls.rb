require 'io/console'

class Prompt
  attr_reader :result

  def initialize(chos, prmpt = nil, err = nil)
    self.choices = chos.map(&:downcase)
    self.error = err || "Sorry, invalid choice."
    self.prompt_message = prmpt || choices_to_string
  end

  def ask
    answer = ''

    loop do
      puts prompt_message
      Prompt.print_prompt
      answer = possible_choices gets.chomp.downcase

      answer = verify_choice answer
      break if answer

      puts error
    end

    self.result = answer
  end

  def self.print_prompt
    print "=> "
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
      Prompt.print_prompt

      index = gets.to_i - 1
      return options[index] if index >= 0 # if none will return nil

      puts "Please enter a number from 1-#{options.size}"
    end
  end

  def print_options(options)
    options += ['None of the above']
    puts "Did you mean? (1-#{options.size})"

    options.each_with_index do |option, index|
      puts "#{index + 1} #{option.capitalize}"
    end
  end

  def choices_to_string
    case choices.size
    when 1 then "#{choices[0]}:"
    when 2 then "#{choices[0]} or #{choices[1]}:"
    else "#{choices[0...-1].join(', ')}, or #{choices[-1]}:"
    end
  end
end

module Banner
  TEXT_WIDTH = 70

  def self.make(str)
    "===| #{str.center(TEXT_WIDTH)} |==="
  end

  def self.print(str)
    puts make(str), nil
  end
end

# I did not implement the moves are a subclass feature of Move. The main
# reason I did not is because I feel that they aren't a good thing to subclass
# due to two reasons. First, they don't have any behaviors that are different.
# Secondly, they only differ in state, they don't require different instance
# variables or require them to be handled differently. They seem to be best
# suited to being a single object together.
#
# If I did add the feature, I'd be gaining a bigger headache in having to
# deal with 5 diffent classes to choose a move and handle string->which class
# needs instantiated. I would gain nothing from this.
#
# It is simple enough to do, just have the individual subclasses set their
# @value instance variable to their option in their initialize and remove the
# initialize method from the Move superclass. Then, I would have a lookup hash
# that uses the move as a key and an instance of each object as a key. When
# the player choses, it would use the hash to determine which object is chosen.
# It feels like a long way of just doing it in the constructor of the Move
# object.
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
  # versions of this would be true.
  #
  # If spock was a different option that say beat paper and rock, while lizard
  # beat scissors and spock, this wouldn't be a possible way to check.
  #
  # If we were to add say Wizard which had an index of 5 that beat lizard,
  # scissors and rock and Rogue at 6, which beat Spock, Paper, and Wizard, with
  # the rest vice versa, it would still work with this algo.
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
  attr_reader :move, :name, :score

  def initialize
    set_name
    reset_score
  end

  def reset_score
    self.score = 0.0
  end

  def reset_choice
    self.move = nil
  end

  def inc_score(value)
    self.score += value
  end

  private

  attr_writer :move, :name, :score
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
      Prompt.print_prompt
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

class RPSGame
  AI = [Computer, HAL, Warbot, BMO, WallE, Femputer, DeepBlue, C3P0].freeze

  attr_reader :winner

  def initialize(human, computer)
    @human = human
    @computer = computer
    human.reset_choice
    computer.reset_choice
  end

  def play
    human.choose
    computer.choose

    display_moves
    set_winner
    display_winner
  end

  def self.display_welcome_message
    $stdout.clear_screen
    Banner.print 'Welcome to Rock, Paper, Scissors, Lizard, Spock!'
  end

  def self.display_goodbye_message
    $stdout.clear_screen
    Banner.print 'Thanks for playing Rock, Paper, Scissors, Lizard, Spock. ' \
      'Good bye!'
  end

  private

  attr_accessor :human, :computer
  attr_writer :winner

  def display_moves
    $stdout.clear_screen
    Banner.print "Rock, Paper, Scissors, Lizard, Spock!"
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}", nil
  end

  def display_winner
    if winner.size == 1
      puts "#{winner[0].name} won!"
    else
      puts "It's a tie!"
    end
  end

  def set_winner
    self.winner = if human.move > computer.move
                    [human]
                  elsif human.move < computer.move
                    [computer]
                  else
                    [human, computer]
                  end
  end
end

class Match
  SLEEP_TIME = 3

  def initialize(game, target_score = 10.0)
    self.game = game
    self.target_score = target_score
    self.round_number = 1

    game.display_welcome_message
    self.human = Human.new
  end

  def play
    loop do
      human.reset_score
      self.computer = game::AI.sample.new

      display_challenger

      play_round until winner?

      display_winner

      break unless play_again?
    end

    game.display_goodbye_message
  end

  private

  attr_accessor :game, :target_score, :human, :computer, :round_number

  def play_round
    round = game.new human, computer

    display_round_info
    round.play

    give_score round.winner
    self.round_number += 1
    sleep SLEEP_TIME
  end

  def give_score(winners)
    winners.each do |winner|
      previous = winner.score

      value = 1 / winners.size.to_f
      winner.inc_score value

      puts "#{winner.name}: #{previous} --> #{winner.score}. " \
        "#{target_score} needed to win."
    end
  end

  def display_challenger
    $stdout.clear_screen
    Banner.print "#{human.name}! #{computer.name} has challenged you to a " \
      "match!"
    puts "Get prepared."
    sleep SLEEP_TIME
  end

  def display_round_info
    $stdout.clear_screen
    Banner.print "Round #{round_number}; #{human.name}: #{human.score} | " \
      "#{computer.name}: #{computer.score} | Win = #{target_score}"
  end

  def display_winner
    $stdout.clear_screen
    Banner.print 'We have a winner!'

    target = target_score
    if human.score == computer.score
      puts "Both reached #{target} points. Its a tie.", nil
    else
      name = human.score >= 10 ? human.name : computer.name
      puts "#{name} was the first to reach #{target} points. #{name} won!", nil
    end

    sleep SLEEP_TIME
  end

  def winner?
    human.score >= target_score || computer.score >= target_score
  end

  def play_again?
    prompt = Prompt.new %w(yes no), 'Would you like to play another match? ' \
      '(Yes or No)'

    prompt.ask

    prompt.result == 'yes'
  end
end

Match.new(RPSGame).play
