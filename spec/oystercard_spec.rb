require 'oystercard'
require 'station'
# require 'journey'


describe Oystercard do
  # let(:station1) {double(:station1, :name => 'victoria', :zone => 1)}
  subject {Oystercard.new( Journey, JourneyLog)}
  let(:station1) {Station.new 'Vic',1}
  # let(:station2) {double(:station2, :name => 'brixton', :zone => 2)}
  # let (:journey){ {:entry_station => station1, :exit_station => station2} }
  let(:station2) {Station.new 'Bri',3}
  # let(:journey) {Journey.new station1}
  let(:topped_up) {Oystercard.new 20, Journey, JourneyLog}
  let(:journey_list) {JourneyLog.new}

  context 'initialize' do
    it 'balance is zero when initialized' do
      expect(subject.balance).to eq 0
    end
  end

  context 'top up' do
    it 'balance increases by top up amount' do
      expect {subject.top_up 1}.to change{subject.balance }.by 1
    end
    it 'error if over maximum balance' do
      expect {subject.top_up((Oystercard::MAXIMUM_BALANCE) + 1)}.to raise_error "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  context 'touch in' do
    it 'has an #entry station' do
      topped_up.touch_in station1
      expect(topped_up.journey.entry).to eq station1
    end
    it 'raise an error if no enough money' do
      expect {subject.touch_in station1}.to raise_error "balance less than minimum fare of £#{Oystercard::MINIMUM_BALANCE}"
    end
    it 'it is still in journey' do
      topped_up.touch_in station1
      expect(topped_up.journey.complete).to eq false
    end
    it 'has been charged of penalty fare ' do
      topped_up.touch_in station1
      expect {topped_up.touch_in station1}.to change {topped_up.balance}.by -Oystercard::PENALTY
    end
  end

  context 'touch out' do
    it '#exit' do
      topped_up.touch_in station1
      topped_up.touch_out station2
      expect(topped_up.journey.exit_station).to eq station2
    end
    it '#not complete' do
      topped_up.touch_in station1
      expect(topped_up.journey.complete).to eq false
    end
    it '#complete' do
      topped_up.touch_in station1
      topped_up.touch_out station2
      expect(topped_up.journey.complete).to eq true
    end
  end

  context 'deduct' do
    it 'the fare has been deducted' do
      topped_up.touch_in station1
      expect {topped_up.touch_out station2}.to change {topped_up.balance}.by -topped_up.journey.fare
    end
  end
end
