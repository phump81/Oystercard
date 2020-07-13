require 'oystercard'

describe Oystercard do

  it 'Adds balance of zero to a new card' do
    expect(subject.balance).to eq(0)
  end
end
