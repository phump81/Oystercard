class Oystercard

  attr_accessor :balance, :journeys, :current_journey

  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1
  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    fail "Balance cannot exceed #{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)

    fail "Already touched in" if in_journey?
    fail "Insufficient funds" if @balance < MINIMUM_AMOUNT

    @current_journey = Journey.new(entry_station)
  end

  def in_journey?
    !(@current_journey.complete?)
  end

  def touch_out(exit_station)

    fail "Already touched out" unless in_journey?

    @current_journey.exit_station = exit_station

    journey =  { :entry_station => @current_journey.entry_station, :exit_station => @current_journey.exit_station }
    @journeys << journey

    deduct(MINIMUM_AMOUNT)
  end

  private

  def deduct(amount)
    @balance -= amount
  end


end
