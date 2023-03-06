class Hand
  def initialize
    @cards = []
  end

  def hit_or_stay
    :stay
  end

  def receive_card(card)
    cards << card
  end

  def busted?
  end

  def total
  end

  private

  attr_accessor :cards
end

class Player < Hand

end

class Dealer < Hand

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
      Card.new *data
    end
    cards.shuffle!
  end

  private

  attr_accessor :cards
end

class Card
  RANKS = %w(A 1 2 3 4 5 6 7 8 9 10 J Q K).freeze
  SUITS = %w(♠ ♣ ♥ ♦).freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    rank + suit
  end
end

class Game
  def initialize
    @deck = Deck.new
    @human = Hand.new
    @dealer = Hand.new
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

  def play
    display_welcome_message

    deal_cards
    p human
    p dealer
    # show_cards
    # player_turn
    # dealer_turn
    # show_result

    display_goodbye_message
  end

  private

  attr_reader :human, :dealer, :deck
end

Game.new.play
