require 'oystercard'
require 'station'
# require 'journey'


describe Oystercard do
  # let(:station1) {double(:station1, :name => 'victoria', :zone => 1)}
  let(:station1) {Station.new 'Vic',1}
  # let(:station2) {double(:station2, :name => 'brixton', :zone => 2)}
  # let (:journey){ {:entry_station => station1, :exit_station => station2} }
  let(:station2) {Station.new 'Bri',3}
  # let(:journey) {Journey.new station1}
  let(:topped_up) {Oystercard.new 20}
  let(:journey_list) {JourneyLog.new}

  it 'balance is zero when initialized' do
    expect(subject.balance).to eq 0
  end

  # describe '#top_up' do
  #   it 'balance increases by top up amount' do
  #     expect {subject.top_up 1}.to change{subject.balance }.by 1
  #   end
  #   it 'error if over maximum balance' do
  #     expect {subject.top_up((Oystercard::MAXIMUM_BALANCE) + 1)}.to raise_error "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
  #   end
  # end
  describe '#deduct' do
    it '#exit' do
      topped_up.touch_in station1
      topped_up.touch_out station2
      expect(topped_up.journey.exit).to eq station2
    end
    it '#entry' do
      topped_up.touch_in station1
      expect(topped_up.journey.entry).to eq station1
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
    it 'balance decreases by deduct amount' do
      # subject.top_up Oystercard::MAXIMUM_BALANCE
      topped_up.touch_in station1
      # expect {subject.touch_out station2}.to change {subject.balance}.by -Oystercard::MINIMUM_BALANCE
      # topped_up.touch_out station2
      # expect(topped_up.journey.fare).to eq (topped_up.journey.entry.zone - topped_up.journey.exit.zone).abs * 2
      # topped_up.touch_out station2
      # expect(topped_up.journey.fare).to eq 4

      # expect {subject.touch_out station2}.to change {subject.balance}.by -topped_up.journey.fare

      startbalance = topped_up.balance
      topped_up.touch_out station2
      endbalance = topped_up.balance
      expect(startbalance-endbalance).to eq (topped_up.journey.entry.zone - topped_up.journey.exit.zone).abs * 2
    end
  end

  # describe 'touch in/out support' do
  #   context 'when touch-in so in journey' do
  #     it 'card touch-in' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       expect(subject).to be_in_journey
  #     end
  #   end
  #   context 'when touch-out so not in journey' do
  #     it 'card touch-out after being touched-in' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       subject.touch_out station2
  #       expect(subject).not_to be_in_journey
  #     end
  #   end
  #   context 'when not used to touch-in so not in journey' do
  #     it 'not in journey if not being used' do
  #       expect(subject).not_to be_in_journey
  #     end
  #   end
  #   context 'when card does not cover minimum fare' do
  #     it 'error raised' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_out station2
  #       expect {subject.touch_in station1}.to raise_error "balance less than minimum fare of £#{Oystercard::MINIMUM_BALANCE}"
  #     end
  #   end
  #   context 'when card touch-out deduct minimum balance' do
  #     it 'touch out and deduct' do
  #       expect {subject.touch_out station2}.to change {subject.balance}.by -Oystercard::MINIMUM_BALANCE
  #     end
  #   end
  #   context 'when touch_in' do
  #     it 'record station' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       expect(subject.entry_station).to eq station1
  #     end
  #     it 'twice penalty fare made' do
  #       topped_up.touch_in station1
  #       expect {topped_up.touch_in station1}.to change {topped_up.balance}.by -Oystercard::PENALTY
  #     end
  #   end
  #   context 'when touch out' do
  #     it 'records station' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       subject.touch_out station2
  #       expect(subject.exit_station).to eq station2
  #     end
  #     it 'has empty list_of_journeys' do
  #       expect(journey_list.log).to be_empty
  #     end
  #     it 'records hash of journey' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       subject.touch_out station2
  #       expect(subject.list_of_journeys.log.count).to eq 1
  #     end
  #     it 'record list of journeys' do
  #       subject.top_up Oystercard::MINIMUM_BALANCE
  #       subject.touch_in station1
  #       subject.touch_out station2
  #       # expect(subject.list_of_journeys).to eq [{:entry_station => station1,:exit_station => station2}]
  #       expect(subject.list_of_journeys.log).to include journey
  #     end
  #   end
  # end

  # describe '#zone and station #name' do
  #   context 'when touch_in' do
  #      it 'journey contain #name info' do
  #        subject.top_up(10)
  #        subject.touch_in(station1)
  #        subject.touch_out(station2)
  #       expect(subject.list_of_journeys.log.last[:entry_station].name).to eq 'victoria'
  #      end

  #      it 'journey contain #zone info' do
  #        subject.top_up(10)
  #        subject.touch_in(station1)
  #        subject.touch_out(station2)
  #       expect(subject.list_of_journeys.log.last[:entry_station].zone).to eq 1
  #      end
  #    end
  # end
end
