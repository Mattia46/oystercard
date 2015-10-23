require 'oystercard'
require 'station'

# describe 'Feature test  - oystercard challenge' do
#   subject {Oystercard.new}
#   let(:station1) {Station.new('V', 1)}
#   let(:station2) {Station.new('B', 3)}
#   let (:journey){ {:entry_station => station1, :exit_station => station2} }
#   let(:topped_up) {Oystercard.new Oystercard::MINIMUM_BALANCE}
#   let(:topped_max) {Oystercard.new Oystercard::MAXIMUM_BALANCE}
#   it 'balance is zero when initialized' do
#     expect(subject.balance).to eq 0
#   end

#   describe '#top_up' do
#     it 'balance increases by top up amount' do
#       expect {subject.top_up 1}.to change{subject.balance }.by 1
#     end
#     it 'error if over maximum balance' do
#       expect {topped_max.top_up 1}.to raise_error "Over maximum balance of #{Oystercard::MAXIMUM_BALANCE}"
#     end
#   end
#   describe '#deduct' do
#     it 'balance decreases by deduct amount' do
#       expect {topped_up.touch_out station2}.to change {topped_up.balance}.by -Oystercard::MINIMUM_BALANCE
#     end
#   end

#   describe 'touch in/out support' do
#     context 'when touch-in so in journey' do
#       it 'card touch-in' do
#         topped_up.touch_in station1
#         expect(topped_up).to be_in_journey
#       end
#     end
#     context 'when touch-out so not in journey' do
#       it 'card touch-out after being touched-in' do
#         topped_up.touch_in station1
#         topped_up.touch_out station2
#         expect(topped_up).not_to be_in_journey
#       end
#     end
#     context 'when not used to touch-in so not in journey' do
#       it 'not in journey if not being used' do
#         expect(subject).not_to be_in_journey
#       end
#     end
#     context 'when card does not cover minimum fare' do
#       it 'error raised' do
#         topped_up.touch_out station2
#         expect {topped_up.touch_in station1}.to raise_error "balance less than minimum fare of £#{Oystercard::MINIMUM_BALANCE}"
#       end
#     end
#     context 'when card touch-out deduct minimum balance' do
#       it 'touch out and deduct' do
#         expect {subject.touch_out station2}.to change {subject.balance}.by -Oystercard::MINIMUM_BALANCE
#       end
#     end
#     context 'when touch_in' do
#       it 'record station' do
#         topped_up.touch_in station1
#         expect(topped_up.entry_station).to eq station1
#       end
#     end
#     context 'when touch out' do
#       it 'records station' do
#         topped_up.touch_in station1
#         topped_up.touch_out station2
#         expect(topped_up.exit_station).to eq station2
#       end
#       it 'has empty list_of_journeys' do
#         expect(subject.list_of_journeys).to be_empty
#       end
#       it 'records hash of journey' do
#         topped_up.touch_in station1
#         topped_up.touch_out station2
#         expect(topped_up.list_of_journeys.count).to eq 1
#       end
#       it 'record list of journeys' do
#         topped_up.touch_in station1
#         topped_up.touch_out station2
#         expect(topped_up.list_of_journeys).to include journey
#       end
#     end
#   end
#   describe '#zone and station #name' do
#     context 'when touch_in' do
#        it 'journey contain #name info' do
#          topped_up.touch_in station1
#          topped_up.touch_out station2
#         expect(topped_up.list_of_journeys.last[:entry_station].name).to eq 'V'
#        end

#        it 'journey contain #zone info' do
#          topped_up.touch_in station1
#          topped_up.touch_out station2
#         expect(topped_up.list_of_journeys.last[:entry_station].zone).to eq 1
#        end
#      end
#   end
# end
