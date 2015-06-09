

module Rules
  ROUNDS = [
    {sets: 1, of: 3},
    {sets: 2, of: 3},
    {sets: 1, of: 4},
    {sets: 2, of: 4},
    {sets: 1, of: 5},
    {sets: 2, of: 5},
    {sets: 1, of: 6},
    {sets: 2, of: 6},
  ]

  WILDS = %w(2h 2s 2d 2c 1j 2j)

  SUITS = {h: 'hearts', s: 'spades', d: 'diamonds', c: 'clubs', j: 'joker'}

  CARDS = %w(joker ace two three four five six seven eight nine ten jack queen king)

  CARDS_NUM = [1..13]

  def round round
    ROUNDS[round - 1]
  end

  def rules round
    "Start with #{ROUNDS[@round][:sets]} set(s) of #{ROUNDS[@round][:of]}"
  end
end
