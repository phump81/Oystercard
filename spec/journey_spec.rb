require 'journey'

describe Journey do

  describe '#initialize' do

    let(:entry_station) { double("entry_station") }
    let(:exit_station) { double("exit_station") }
    let(:journey) { Journey.new(entry_station) }

    it 'gets an entry_station' do
      expect(journey.entry_station).to eq(entry_station)
    end

    it 'gets an exit station' do
      journey.finish(exit_station)
      expect(journey.exit_station).to eq(exit_station)
    end
  end

  describe '#fare' do

    let(:entry_station) { double("entry_station") }
    let(:exit_station) { double("exit_station") }
    let(:journey) { Journey.new(entry_station) }

    it 'returns the minimum fare' do
      journey.finish(exit_station)
      expect(journey.fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'returns penalty fare when no exit station' do
      expect(journey.fare).to eq(Journey::PENALTY_FARE)
    end

    it 'returns penalty fare when no entry station' do
      noentry = Journey.new
      noentry.finish(exit_station)
      expect(noentry.fare).to eq(Journey::PENALTY_FARE)
    end
  end

  describe '#complete?' do

    let(:entry_station) { double("entry_station") }
    let(:exit_station) { double("exit_station") }
    let(:journey) { Journey.new(entry_station) }

    it 'checks if a journey is complete' do
      journey.finish(exit_station)
      expect(journey.complete?).to eq(true)
    end

    it 'checks if a journey is incomplete' do
      expect(journey.complete?).to eq(false)
    end

  end
end
