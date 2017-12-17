describe HomePageController do
  describe 'GET index' do
    let(:country) { double(:country, id: 1) }
    before do
      allow(CountryIDLookuper).to receive(:lookup).and_return(country)
      get(:index)
    end

    it { expect(response).to be_success }
    it { expect(subject).to render_template('home_page/index') }
  end
end
