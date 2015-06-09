require_relative '../rules'

class Card
  attr_reader :card_raw
  def initialize card
    @card_raw = card
    @card_num = card[0..-2].to_i
    @card_suit = card[-1].to_sym
    @wild = Rules::WILDS.include? @card_raw
  end

  def if_wild
    yield if @wild
  end

  def if_not_wild
    yield unless @wild
  end

  def suit
    Rules::SUITS[@card_suit]
  end

  def set_name
    if @card_suit != :j
      Rules::CARDS[@card_num]
    else
      'joker'
    end
  end

  def to_s
    "#{@card_num} of #{suit}"
  end
end
