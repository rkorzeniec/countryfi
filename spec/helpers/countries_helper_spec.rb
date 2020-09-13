# frozen_string_literal: true

describe CountriesHelper do
  describe '#visit_badge' do
    subject { helper.visit_badge(country) }

    let(:country) { double(:country, id: 1, to_i: 1) }
    let(:checkins) { Checkin.all }
    let(:user) { instance_double(User, checkins: checkins) }

    context 'with user' do
      before { allow(helper).to receive(:current_user).and_return(user) }

      context 'when country is not visited nor upcoming' do
        it { is_expected.to be_nil }
      end

      context 'when country is visited' do
        let(:checkin) { instance_double(Checkin, in_past?: true) }

        before do
          allow(checkins).to receive(:find_by)
            .with(country: country)
            .and_return(checkin)
        end

        it do
          expect(subject).to eq(
            '<span class="badge badge-sm text-sm badge-success">visited</span>'
          )
        end
      end

      context 'when country is upcoming' do
        let(:checkin) { instance_double(Checkin, in_past?: false) }

        before do
          allow(checkins).to receive(:find_by)
            .with(country: country)
            .and_return(checkin)
        end

        it do
          expect(subject).to eq(
            '<span class="badge badge-sm text-sm badge-info">upcoming</span>'
          )
        end
      end
    end

    context 'without user' do
      before { allow(helper).to receive(:current_user).and_return(nil) }

      it { is_expected.to be_nil }
    end
  end
end
