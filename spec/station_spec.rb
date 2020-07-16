require 'station'

describe Station do

  subject {described_class.new("Bank", 1)}

  it 'exposes name of station' do
    expect(subject.name).to eq("Bank")
  end

  it 'exposes zone of station' do
    expect(subject.zone).to eq(1)
  end
end
