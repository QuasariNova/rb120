class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
                   [1, 4, 7], [2, 5, 8], [3, 6, 9],
                   [1, 5, 9], [3, 5, 7]]

  attr_reader :squares

  def initialize
    @squares = {}
    reset
  end

  def draw
    puts <<~BOARD
         |     |
      #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}
         |     |
    -----+-----+-----
         |     |
      #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}
         |     |
    -----+-----+-----
         |     |
      #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}
         |     |
    BOARD
  end

  def []=(key, value)
    squares[key].marker = value
  end

  def unmarked_keys
    squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_mark
  end

  # return winning marker or nil
  def winning_mark
    WINNING_LINES.each do |line|
      win = line.uniq { |key| squares[key].marker }
      return squares[line[0]].marker if win.one? && !squares[win[0]].unmarked?
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
end

class Square
  INITIAL_MARKER = ' '

  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new 'X'
    @computer = Player.new 'O'
  end

  def clear
    system 'clear'
  end

  def display_welcome_message
    clear
    puts "Welcome to Tic Tac Toe!", nil
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_board
    puts "You are a #{human.marker}. Computer is a #{computer.marker}.", nil
    board.draw
    puts nil
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.join(', ')}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include? square
      puts "Sorry, that's a not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_mark
    when human.marker
      puts 'You won!'
    when computer.marker
      puts 'Computer won!'
    else
      puts 'It is a tie.'
    end
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!", nil
  end

  def play
    display_welcome_message
    loop do
      display_board

      loop do
        human_moves
        break if board.someone_won? || board.full?

        computer_moves
        clear_screen_and_display_board
        break if board.someone_won? || board.full?
      end
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
