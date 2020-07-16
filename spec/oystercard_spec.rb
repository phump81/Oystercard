require 'oystercard'

describe Oystercard do

  let(:entry_station) { double("Station") }
  let(:exit_station) { double("Station")}
  let(:journey) { {:entry_station => entry_station, :exit_station => exit_station} }

  it 'Adds balance of zero to a new card' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up(amount)' do
    it 'increases the balance by amount' do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end
    it 'throw an error if the new balance is above limit' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      expect { subject.top_up(1) }.to raise_error "Balance cannot exceed #{Oystercard::BALANCE_LIMIT}"
    end
  end

  describe '#touch_in' do
    it 'Changes in_journey to true' do
    subject.top_up(Oystercard::MINIMUM_AMOUNT)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq true
    end

    it 'Prevents touching in when in journey' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      expect { subject.touch_in(entry_station) }.to raise_error("Already touched in")
    end

    it 'throws an error if balance is less than minimum amount' do
      expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds'
    end

    it 'Remembers the entry station' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    it 'Changes in_journey to false' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end

    it 'Prevents touching out when not in journey' do
      expect { subject.touch_out(exit_station) }.to raise_error("Already touched out")
    end

    it 'Deducts balance by the minimum amount' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-Oystercard::MINIMUM_AMOUNT)
    end

    it 'Sets entry station to nil' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq(nil)
    end

    it 'stores exit station' do
      subject.top_up(Oystercard::MINIMUM_AMOUNT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end

  it 'checks card has an empty list of journeys' do
    expect(subject.journeys).to be_empty
  end

  it 'stores a journey' do
    subject.top_up(Oystercard::MINIMUM_AMOUNT)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end
end
