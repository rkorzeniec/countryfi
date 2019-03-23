describe ApplicationHelper do
  describe '#page_title' do
    subject { helper.page_title }

    context 'when default title' do
      it { is_expected.to eq('Countrify') }
    end

    context 'when page title' do
      let(:title) { 'Checkins | Countrify' }

      it do
        assign(:page_title, title)
        is_expected.to eq(title)
      end
    end
  end

  describe '#render_date' do
    subject { helper.render_date(date) }

    context 'when date is provided' do
      let(:date) { Time.zone.now }

      it { is_expected.to eq(date.strftime('%Y-%m-%d')) }
    end

    context 'when date is not provided' do
      let(:date) { nil }

      it { is_expected.to be_nil }
    end
  end

  describe '#nav_item_id' do
    subject { helper.nav_item_id(path) }

    context 'when path is provided' do
      let(:path) { '/mambo/jambo' }

      it { is_expected.to eq('mambo-jambo') }
    end
  end

  describe '#gravatar_url' do
    subject { helper.gravatar_url(20) }

    context 'when user signed in' do
      let(:user) { double('user', email: 'jon@snow.com') }

      before { allow(helper).to receive(:current_user).and_return(user) }

      it do
        is_expected.to eq(
          'https://gravatar.com/avatar/0aa05c29c41531fa903aa5006389fa23.png?s=20&d=mp'
        )
      end
    end

    context 'when user not signed in' do
      before { allow(helper).to receive(:current_user).and_return(nil) }

      it do
        is_expected.to eq(
          'https://gravatar.com/avatar/d41d8cd98f00b204e9800998ecf8427e.png?s=20&d=mp'
        )
      end
    end
  end
end
