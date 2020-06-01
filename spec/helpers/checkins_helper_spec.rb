# frozen_string_literal: true

describe CheckinsHelper do
  describe '#selected_country' do
    subject { helper.selected_country(checkin) }

    before { allow(helper).to receive(:params).and_return(params) }

    context 'when checkin supplied' do
      let(:checkin) { build_stubbed(:checkin) }
      let(:params) { {} }

      it { expect(subject).to eq(checkin.country_id) }
    end

    context 'when checkin not supplied' do
      let(:checkin) { nil }
      let(:params) { { country: 'CH' } }

      it do
        expect(CountryIDLookuper).to receive(:lookup).with('CH')
        subject
      end
    end
  end
end
