# frozen_string_literal: true

describe ShellController do
  describe 'GET index' do
    before { get(:index) }

    it { expect(response).to be_successful }
    it { expect(subject).to render_template('shell/index') }
  end
end
