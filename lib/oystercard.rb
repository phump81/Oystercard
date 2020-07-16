class Oystercard

  attr_accessor :balance, :entry_station, :exit_station, :journeys

  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @journeys = []
  end

  def top_up(amount)
    fail "Balance cannot exceed #{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)

    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if @balance < MINIMUM_AMOUNT

    @entry_station = entry_station
  end

  def in_journey?
    !!@entry_station
  end

  def touch_out(exit_station)

    fail "Already touched out" unless in_journey?

    @exit_station = exit_station

    journey =  { :entry_station => entry_station, :exit_station => exit_station }
    @journeys << journey

    @entry_station = nil
    deduct(MINIMUM_AMOUNT)

  end

  private

  def deduct(amount)
    @balance -= amount
  end


end
