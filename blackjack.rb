require 'pry'

CARD_SUIT = ['Spade', 'Heart', 'Diamond', 'Club']
CARD_VALUE = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

deck = CARD_SUIT.product(CARD_VALUE)

# Deal Card

dealer_cards = []
player_cards = []
player_total = []
dealer_total = []

def deal_cards(d_card, p_card, deck)
  deck.shuffle!
  loop do
  p_card.push(deck.pop)
  d_card.push(deck.pop)
  break if p_card.size == 2 && d_card.size == 2
  end
end

def display_table_information(d_card, p_card)
  puts "The dealer's card is #{d_card[1]}"
  puts "Your cards are #{p_card[0]} and #{p_card[1]}"
end

def calculate_card_total(cards, total)
  cards.each do |card|
    total.push(card[1])
  end

  tens = ["J","Q","K","A"]
  
  total.each_with_index do |value, index|
    tens.each do |ten|
      if ten == value
          total[index] = "10"
      end
    end
  end

  total = total.map!(&:to_i).inject(:+) 
end

def hit_or_stand?
  puts "Would you like to hit or stand?(y/n)"
  
  begin
    answer = gets.chomp.downcase
    unless answer == "y" || answer == "n"
      puts "Please input [y] for hit and [n] for stand." 
    end 
  end until answer == "y" || answer == "n"

  if answer == "y"
    true
  end
end

def hit(cards, deck)
  loop do
    if hit_or_stand?  
      cards.push(deck.pop)
    else
      break
    end
    puts "Your got a #{cards.last}"
    puts "You have #{cards}"
  end
end





deal_cards(dealer_cards, player_cards, deck)
display_table_information(dealer_cards, player_cards)
# calculate_card_total(player_cards, player_total)
hit(player_cards,deck)
display_table_information(dealer_cards, player_cards)


p player_cards





