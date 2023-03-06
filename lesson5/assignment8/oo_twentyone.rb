class Hand
  def initialize
    @cards = []
  end

  def receive_card(card)
    cards << card
  end

  def to_s
    cards.join(' ')
  end

  def busted?
    total > 21
  end

  def total
    ttl = cards.sum(&:value)
    aces = cards.select { |card| card.rank == 'A' }
    aces.size.times do
      break unless ttl > 21
      ttl -= 10
    end
    ttl
  end

  private

  attr_accessor :cards
end

class Player < Hand
  attr_reader :name

  def initialize
    super
    @name = "Player"
  end

  def hit_or_stay
    answer = nil
    loop do
      puts "Would you like to hit or stay?"
      print "=> "
      answer = gets.chomp.downcase
      break if ['hit', 'stay'].include? answer
      puts "Please input hit or"
    end
    answer.to_sym
  end
end

class Dealer < Hand
  attr_reader :name

  def initialize
    super
    @hidden = true
    @name = "Dealer"
  end

  def reveal
    @hidden = false
  end

  def to_s
    return super unless hidden
    "?? #{cards[1..-1].join(' ')}"
  end

  def hit_or_stay
    if total < 17
      :hit
    else
      :stay
    end
  end

  private

  attr_reader :hidden
end

class Deck
  def initialize
    shuffle
  end

  def draw
    cards.pop
  end

  def shuffle
    self.cards = Card::RANKS.product(Card::SUITS).map do |data|
      Card.new(*data)
    end
    cards.shuffle!
  end

  private

  attr_accessor :cards
end

class Card
  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K).freeze
  SUITS = %w(♠ ♣ ♥ ♦).freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    rank + suit
  end

  def value
    value = RANKS.index(rank) + 1
    return 11 if value == 1
    return 10 if value > 10
    value
  end
end

class Game
  def initialize
    reset
  end

  def play
    display_welcome_message

    loop do
      deal_cards
      player_turn human
      player_turn dealer unless human.busted?
      show_result
      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  private

  attr_reader :human, :dealer, :deck

  def reset
    @deck = Deck.new
    @human = Player.new
    @dealer = Dealer.new
  end

  def winner_message
    human = self.human
    dealer = self.dealer
    if human.busted? || !dealer.busted? && dealer.total > human.total
      "#{dealer.name} has won!"
    elsif dealer.busted? || !human.busted? && human.total > dealer.total
      "#{human.name} has won!"
    else
      "It's a tie!"
    end
  end

  def display_welcome_message
    puts "Welcome to 21"
  end

  def display_goodbye_message
    puts "Thanks for playing 21"
  end

  def deal_cards
    2.times do
      human.receive_card deck.draw
      dealer.receive_card deck.draw
    end
  end

  def show_cards
    puts "#{human.name} has: #{human}"
    puts "#{dealer.name} has: #{dealer}"
  end

  def player_turn(player)
    player.reveal if player == dealer
    loop do
      show_cards
      action = player.hit_or_stay
      puts "#{player.name} #{action}s."
      perform_hit player if action == :hit
      break if player.busted? || action == :stay
    end
    puts "#{player.name} busted" if player.busted?
  end

  def perform_hit(player)
    card = deck.draw
    puts "#{player.name} receives #{card}."
    player.receive_card card
  end

  def show_result
    show_cards
    puts "#{human.name} has #{human.total}"
    puts "#{dealer.name} has #{dealer.total}"
    puts winner_message
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      print "=> "
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end
end

Game.new.play
