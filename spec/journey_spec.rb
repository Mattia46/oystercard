require './lib/journey'
require './lib/station'

describe Journey do
  let(:station1) {Station.new 'Vic',1}
  let(:station2) {Station.new 'Bri',3}
  let(:journey1) {Journey.new station1}
  context 'when new journey' do
    it 'entry station' do
      expect(journey1.entry).to eq station1
    end
    it 'exit station' do
      journey1.exit = station2
      expect(journey1.exit).to eq station2
    end
    it 'set fare' do
      journey1.exit = station2
      faretest = (journey1.entry.zone - journey1.exit.zone).abs * 2
      expect(journey1.fare).to eq faretest
    end
    it 'set journey not complete' do
      expect(journey1.complete).to eq false
    end
    it 'journey  complete' do
      journey1.exit = station2
      expect(journey1.complete).to eq true
    end
  end


end