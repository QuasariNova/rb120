# Consider the following broken code:

# class Wallet
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end

# Modify this code so it works. Do not make the amount in the wallet accessible
# to any method that isn't part of the Wallet class.

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected
  attr_reader(:amount)
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# Further Exploration

# This example is rather contrived and unrealistic, but this type of situation
# occurs frequently in applications. Can you think of any applications where
# protected methods would be desirable?

# ---
# The main thing I see from it is if you want to keep the way the system works
# under wraps, but it that secret is what is necessary for it to interact with
# others.

# Take ranking systems in online games. Typically there is a hidden ELO system
# Underlying a ranking system. Each players data has an ELO and needs to know
# other players ELO in order properly increase/decrease after matches. The game
# however is set up so that players only know that they are "Gold" or
# "Platinum". The individual player is not intended to see the underlying
# number. You can't make it public, because then the player would know, but you
# can't make it private because other player objects wouldn't be able to
# interact with that value. Being protected makes sense here.
