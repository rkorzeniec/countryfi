# frozen_string_literal: true

describe ServiceWorkerController do
  describe 'GET service_worker' do
    before { get(:service_worker) }

    it { expect(response).to be_successful }
    it { expect(subject).to render_template('service_worker/service_worker') }
  end

  describe 'GET manifest' do
    before { get(:manifest) }

    it { expect(response).to be_successful }
    it { expect(subject).to render_template('service_worker/manifest') }
  end
end
