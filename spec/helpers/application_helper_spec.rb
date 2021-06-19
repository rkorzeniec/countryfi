# frozen_string_literal: true

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
    subject { helper.nav_item_id(path, scope: scope) }

    let(:scope) { nil }

    context 'when path is provided' do
      let(:path) { '/mambo' }

      it { is_expected.to eq('mambo') }
    end

    context 'with scope params' do
      let(:path) { '/mambo' }
      let(:scope) { 'jambo' }

      it { is_expected.to eq('mambo-jambo') }
    end
  end

  describe '#gravatar_url' do
    subject { helper.gravatar_url(20) }

    context 'when user signed in' do
      let(:user) { instance_double(User, email: 'jon@snow.com') }

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

  describe '#user_preferences_colour' do
    subject { helper.user_preferences_colour }

    context 'when colour preference exists' do
      let(:user) { instance_double(User, color: '#123456') }

      before { allow(helper).to receive(:current_user).and_return(user) }

      it { is_expected.to eq('#123456') }
    end

    context 'when no colour preference exists' do
      let(:user) { instance_double(User, color: nil) }

      before { allow(helper).to receive(:current_user).and_return(user) }

      it { is_expected.to eq('#D70206') }
    end

    context 'when no current user' do
      before { allow(helper).to receive(:current_user).and_return(nil) }

      it { is_expected.to eq('#D70206') }
    end
  end

  describe '#flash_message_css_class' do
    subject { helper.flash_message_css_class(message_type) }

    context 'when success' do
      let(:message_type) { 'success' }

      it { is_expected.to eq('alert-success') }
    end

    context 'when error' do
      let(:message_type) { 'error' }

      it { is_expected.to eq('alert-danger') }
    end

    context 'when alert' do
      let(:message_type) { 'alert' }

      it { is_expected.to eq('alert-danger') }
    end

    context 'when success' do
      let(:message_type) { 'success' }

      it { is_expected.to eq('alert-success') }
    end

    context 'when notice' do
      let(:message_type) { 'notice' }

      it { is_expected.to eq('alert-info') }
    end

    context 'when info' do
      let(:message_type) { 'info' }

      it { is_expected.to eq('alert-info') }
    end

    context 'when warning' do
      let(:message_type) { 'warning' }

      it { is_expected.to eq('alert-warning') }
    end
  end
end
