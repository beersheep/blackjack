require 'pry'

CARD_SUIT = ['Spade', 'Heart', 'Diamond', 'Club']
CARD_VALUE = ['2','3','4','5','6','7','8','9','10','J','Q','K','A']

deck = CARD_SUIT.product(CARD_VALUE)

dealer_cards = []
player_cards = []

def blackjack?(cards)
  calculate_card_total(cards) == 21 ? true : false
end

def busted?(cards)
  calculate_card_total(cards) > 21 ? true : false
end

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

def display_result(d_card, d_total, p_card, p_total)
  puts "=> Your hand are "
  p_card.each do |card|
    puts "#{card}"
  end
  puts "for a total #{p_total}"

  puts "=> Dealer's hand are "
  d_card.each do |card|
    puts "#{card}"
  end

  puts "for a total #{d_total}"

  if p_total > d_total
    puts "You win!"
  elsif d_total > p_total
    puts "You lose!"
  else 
    puts "Push!"
  end
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

def player_turn(cards, deck)
 
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
      if busted?(cards)
        puts "Busted! You lose!"
        exit
      elsif blackjack?(cards)
        puts "Blackjack! You win!"
        exit
      end
    else 
      system "clear"
      if blackjack?(cards)
        puts "Blackjack! You win!"
        exit 
    end
      break
    end
  end
end

def dealer_turn(cards, deck, p_total)

  sleep 0.5
  puts "dealer's hand are #{cards}"

  total = calculate_card_total(cards)
     
  while total < 17 || total < p_total
    puts "Dealer hits a card!"
    sleep 0.3
    hit(cards, deck)
    puts "Dealer gets a #{cards.last}"
    puts "Dealer has #{cards}"
    calculate_card_total(cards)
    if blackjack?(cards)
      puts "Dealer hits blackjack! You lose!"
      exit
    elsif busted?(cards)
      puts "Dealer Busted! You Win!"
      exit
    else
      break
    end
  end 
  puts "Dealer stands"
  calculate_card_total(cards)
end

deal_cards(dealer_cards, player_cards, deck)
display_table_information(dealer_cards, player_cards)
player_turn(player_cards, deck)
player_total = calculate_card_total(player_cards)
dealer_turn(dealer_cards, deck, player_total)
dealer_total = calculate_card_total(dealer_cards)
display_result(dealer_cards, dealer_total, player_cards, player_total)
# binding.pry



