class Player
  def initialize
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Dealer
  def initialize
  end

  def deal # This or deck?
  end

  def hit
  end

  def stay
  end

  def busted?
  end

  def total
  end
end

class Participant # Maybe
end

class Deck
  def initialize
  end

  def deal # Dealer or here?
  end
end

class Card
  def initialize
  end
end

class Game
  def initialize
  end

  def play
    display_welcome_message

    deal_cards
    show_cards
    player_turn
    dealer_turn
    show_result

    display_goodbye_message
  end
end

Game.new.play
