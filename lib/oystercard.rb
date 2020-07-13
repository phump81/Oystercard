class Oystercard

  attr_accessor :balance

  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance cannot exceed #{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in

    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if @balance < MINIMUM_AMOUNT 

    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out

    fail "Already touched out" unless in_journey?

    deduct(MINIMUM_AMOUNT)
    @in_journey = false
  end

  private
  
  def deduct(amount)
    @balance -= amount
  end


end
