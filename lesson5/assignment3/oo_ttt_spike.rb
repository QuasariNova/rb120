# Tic Tac Toe is a 2-player board game played on a 3x3 grid. Players take turns
# marking a square. The first player to mark 3 squares in a row wins.

# Nouns: board, player, square, grid
# Verbs: play, mark

# Board
# Square
# Player
# - mark
# - play

class Board
  INITIAL_MARKER = ' '

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new INITIAL_MARKER }
  end

  def [](key)
    @squares[key]
  end

  def []=(key, value)
    @squares[key] = value
  end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new 'X'
    @computer = Player.new 'O'
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!", nil
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts <<~BOARD

         |     |
      #{board[1]}  |  #{board[2]}  |  #{board[3]}
         |     |
    -----+-----+-----
         |     |
      #{board[4]}  |  #{board[5]}  |  #{board[6]}
         |     |
    -----+-----+-----
         |     |
      #{board[7]}  |  #{board[8]}  |  #{board[9]}
         |     |

    BOARD
  end

  def human_moves
    puts "Choose a square between 1-9:"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if (1..9).include? square
      puts "Sorry, that's a not a valid choice."
    end

    board[square] = human.marker
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      display_board
      break
      break if someone_won? || board_full?

      computer_moves
      break if someone_won? || board_full?
    end
    # display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
