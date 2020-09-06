# frozen_string_literal: true

describe HelloController do
  describe 'GET index' do
    let(:country) { instance_double(Country, id: 1) }

    before do
      allow(CountryIdFinder).to receive(:lookup).and_return(country)
      get(:index)
    end

    it { expect(response).to be_successful }
    it { expect(subject).to render_template('hello/index') }
  end

  context 'when user authenticated' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      get(:index)
    end

    it { expect(response).to redirect_to(dashboard_path) }
  end
end
