# frozen_string_literal: true

describe Users::PreferencesForm, type: :form do
  let(:user) { build_stubbed(:user) }
  let(:base_params) { { countries: 'all' } }
  let(:params) { base_params.merge({}) }
  let(:form) { described_class.new(user, params) }

  describe 'validations' do
    subject { form }

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
