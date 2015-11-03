require 'pry'

CARD_SUIT = ['Spade', 'Heart', 'Diamond', 'Club']
CARD_VALUE = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

deck = CARD_SUIT.product(CARD_VALUE)

# Deal Card

dealer_cards = []
player_cards = []

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

def calculate_card_total(cards)

  card_value = cards.map{|card| card[1]}
  total = 0

  card_value.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end

  card_value.select {|value| value == "A"}.count.times do
      total -= 10 if total > 21
  end

  total
end

def hit(cards, deck)
  cards.push(deck.pop) 
end

def hit_or_stand?(cards, deck)
 
  loop do 
  puts "Would you like to hit or stand?(y/n)"
  
  begin
    answer = gets.chomp.downcase
    unless answer == "y" || answer == "n"
      puts "Please input [y] for hit and [n] for stand." 
    end 
  end until answer == "y" || answer == "n"
  
    if answer == "y"
      hit(cards, deck)
      puts "Your got a #{cards.last}"
      puts "You have #{cards}"
      calculate_card_total(cards)
    else break
    end

  end
  
  puts "You have #{cards}"
end

def check_busted(cards, total)
  
  puts "You are busted" if total > 21
  exit
  
end

deal_cards(dealer_cards, player_cards, deck)
display_table_information(dealer_cards, player_cards)
hit_or_stand?(player_cards, deck)
player_total = calculate_card_total(player_cards)



# p player_cards
# binding.pry


# tens = ["J","Q","K","A"]
# player_cards.each do |card|
#   tens.each do |ten|
#     if card.include?(ten)
#       p "matches"
#     end
#   end
# end


# display_table_information(dealer_cards, player_cards)


# p player_cards

# To see if J, Q, K, A included
# tens = ["J","Q","K","A"]
# player_cards.each do |card|
#   tens.each do |ten|
#     if card.include?(ten)
#       p "matches"
#     end
#   end
# end



