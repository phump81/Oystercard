require 'oystercard'

describe Oystercard do

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
end
