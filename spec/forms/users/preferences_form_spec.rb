# frozen_string_literal: true

describe Users::PreferencesForm, type: :form do
  let(:user) { build_stubbed(:user) }
  let(:base_params) { { countries: 'all', public_profile: '0' } }
  let(:params) { base_params.merge({}) }
  let(:form) { described_class.new(user, params) }

  describe 'validations' do
    subject { form }

    describe 'public_profile' do
      it { is_expected.to validate_presence_of(:public_profile) }
      it do
        is_expected.to validate_inclusion_of(:public_profile)
          .in_array(%w[0 1])
      end
    end

    describe 'profile' do
      let(:base_params) { { countries: 'all', public_profile: '1' } }

      it do
        is_expected.to validate_length_of(:profile)
          .is_at_least(4)
          .is_at_most(20)
      end

      context 'when only characters' do
        let(:params) { base_params.merge({ profile: 'abcd' }) }

        it { is_expected.to be_valid }
      end

      context 'when only numbers' do
        let(:params) { base_params.merge({ profile: '1234' }) }

        it { is_expected.to be_valid }
      end

      context 'when alphanumerics' do
        let(:params) { base_params.merge({ profile: 'abcd1234' }) }

        it { is_expected.to be_valid }
      end

      context 'when nil' do
        let(:params) { base_params.merge({ profile: nil }) }

        it do
          is_expected.to be_invalid
          expect(form.errors.messages[:profile]).to include('is invalid')
        end
      end

      context 'when empty' do
        let(:params) { base_params.merge({ profile: '' }) }

        it do
          is_expected.to be_invalid
          expect(form.errors.messages[:profile]).to include('is invalid')
        end
      end
    end

    describe 'countries' do
      it { is_expected.to validate_presence_of(:countries) }
      it do
        is_expected.to validate_inclusion_of(:countries)
          .in_array(%w[all un_member independent])
      end
    end

    describe 'color' do
      let(:params) { base_params.merge({ color: nil }) }

      it { is_expected.to be_valid }

      context 'when valid' do
        context 'with short format' do
          context 'when chars' do
            let(:params) { base_params.merge({ color: '#abC' }) }

            it { is_expected.to be_valid }
          end

          context 'when numericals' do
            let(:params) { base_params.merge({ color: '#000' }) }

            it { is_expected.to be_valid }
          end

          context 'when mixed' do
            let(:params) { base_params.merge({ color: '#ee0' }) }

            it { is_expected.to be_valid }
          end
        end

        context 'with long format' do
          context 'when chars' do
            let(:params) { base_params.merge({ color: '#AbcDeF' }) }

            it { is_expected.to be_valid }
          end

          context 'when numericals' do
            let(:params) { base_params.merge({ color: '#123456' }) }

            it { is_expected.to be_valid }
          end

          context 'when mixed' do
            let(:params) { base_params.merge({ color: '#ABC123' }) }

            it { is_expected.to be_valid }
          end
        end
      end

      context 'when invalid' do
        context 'with incorrect characters' do
          let(:params) { base_params.merge({ color: '#FFG' }) }

          it do
            is_expected.to be_invalid
            expect(form.errors.messages[:color]).to eq(['is invalid'])
          end
        end

        context 'when between lengths' do
          let(:params) { base_params.merge({ color: '#ff11' }) }

          it do
            is_expected.to be_invalid
            expect(form.errors.messages[:color]).to eq(['is invalid'])
          end
        end

        context 'when too short' do
          let(:params) { base_params.merge({ color: '#f1' }) }

          it do
            is_expected.to be_invalid
            expect(form.errors.messages[:color]).to eq(['is invalid'])
          end
        end

        context 'when too long' do
          let(:params) { base_params.merge({ color: '#1234567' }) }

          it do
            is_expected.to be_invalid
            expect(form.errors.messages[:color]).to eq(['is invalid'])
          end
        end
      end
    end
  end

  describe '#save' do
    subject { form.save }

    let(:user) { create(:user, countries_cluster: 'independent') }

    context 'when valid' do
      it do
        expect { subject }.to change { user.reload.countries_cluster }
          .from('independent').to('all')
      end

      context 'with color' do
        let(:params) { base_params.merge({ color: '#EE00CC' }) }

        it do
          expect { subject }.to change { user.reload.countries_cluster }
            .from('independent').to('all')
            .and change { user.color }.from(nil).to('#EE00CC')
        end
      end
    end

    context 'when invalid' do
      let(:params) { base_params.merge({ color: '#' }) }

      it { is_expected.to be false }
    end
  end

  describe '#persisted?' do
    subject { form.persisted? }

    it { is_expected.to be false }
  end
end
