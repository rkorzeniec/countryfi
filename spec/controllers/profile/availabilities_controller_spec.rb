# frozen_string_literal: true

describe Profile::AvailabilitiesController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :show, { params: {} }]
    ]
  end

  describe 'GET show' do
    subject { get(:show, format: :json, params: params) }

    let(:params) { { profile: 'mambo' } }

    before { sign_in(user) }

    context 'when available' do
      it do
        is_expected.to be_successful
        expect(JSON.parse(response.body)).to eq({ 'availability' => true })
      end
    end

    context 'when unavailable' do
      let(:user) { create(:user, profile: 'mambo') }

      it do
        is_expected.to be_successful
        expect(JSON.parse(response.body)).to eq({ 'availability' => false })
      end
    end
  end
end
