describe StaticPagesController do
  context 'when user signed in' do
    describe 'GET home' do
      before { get(:home) }

      it { expect(response).to be_success }
      it { expect(subject).to render_template('static_pages/home') }
    end
  end
end
