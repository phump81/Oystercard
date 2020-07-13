class Oystercard

  attr_accessor :balance
  
  BALANCE_LIMIT = 90
  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Balance cannot exceed #{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

end
