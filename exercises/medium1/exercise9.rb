# Using the Card class from the previous exercise, create a Deck class that
# contains all of the standard 52 playing cards. Use the following code to
# start your work:

# class Deck
#   RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
#   SUITS = %w(Hearts Clubs Diamonds Spades).freeze
# end

# The Deck class should provide a #draw method to deal one card. The Deck
# should be shuffled when it is initialized and, if it runs out of cards, it
# should reset itself by generating a new set of 52 shuffled cards.

# Examples:

# deck = Deck.new
# drawn = []
# 52.times { drawn << deck.draw }
# drawn.count { |card| card.rank == 5 } == 4
# drawn.count { |card| card.suit == 'Hearts' } == 13

# drawn2 = []
# 52.times { drawn2 << deck.draw }
# drawn != drawn2 # Almost always.

# Note that the last line should almost always be true; if you shuffle the deck
# 1000 times a second, you will be very, very, very old before you see two
# consecutive shuffles produce the same results. If you get a false result, you
# almost certainly have something wrong.

class Deck
  def initialize
    shuffle
  end

  def draw
    shuffle if deck.empty?
    deck.pop
  end

  private

  attr_reader :deck

  def shuffle
    @deck = Card::RANKS.product(Card::SUITS).map do |arr|
      Card.new(*arr)
    end
    deck.shuffle!
  end
end

class Card
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10 ,'Jack', 'Queen', 'King', 'Ace'].freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  attr_reader :suit

  include Comparable

  def initialize(rank, suit)
    @rank_index = RANKS.index(rank)
    @suit = suit
  end

  def rank
    RANKS[rank_index]
  end

  def <=>(other)
    rank_index <=> other.rank_index
  end
  protected

  attr_reader :rank_index
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
