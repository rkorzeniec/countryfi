# frozen_string_literal: true

describe Countries::DataUpdater do
  let(:updater) { described_class.new(path) }
  let(:path) { Rails.root.join('spec/support/fixtures/countries_data.yml') }

  describe '#call' do
    subject { updater.call }

    it do
      expect { subject }.to change { Country.count }.from(0).to(10)
    end

    it do
      expect { subject }.to change { BorderCountry.count }.from(0).to(13)
    end
  end
end
