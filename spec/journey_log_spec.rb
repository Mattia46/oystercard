require 'journey_log'



describe JourneyLog do
  let(:station1) {double(:station1, :name => 'victoria', :zone => 1)}
  let(:station2) {double(:station2, :name => 'brixton', :zone => 2)}
  let (:journey){ {:entry_station => station1, :exit_station => station2} }

  context 'list of journeys' do
    it 'includes journey' do
      subject.log = journey
      expect(subject.log).to include journey
    end
  end


end