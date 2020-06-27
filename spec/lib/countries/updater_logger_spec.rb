# frozen_string_literal: true

describe Countries::UpdaterLogger do
  let(:updater_klass) do
    UpdaterTestClass = Class.new do
      include Countries::UpdaterLogger
    end
  end

  describe '#log_update' do
    subject { updater.log_update(object, columns) }

    let(:updater) { updater_klass.new }
    let(:columns) { nil }
    let(:object) do
      instance_double(
        Country,
        previous_changes: {
          'foo' => [nil, 1],
          'bar' => %w[baz bax],
          'mambo' => ['jambo', nil]
        }
      )
    end

    it do
      expect(Rails.logger).to receive(:info)
        .with('RSpec::Mocks::InstanceVerifyingDouble: {}')
      subject
    end

    context 'with columns' do
      let(:columns) { %w[bar mambo] }

      it do
        expect(Rails.logger).to receive(:info)
          .with(
            'RSpec::Mocks::InstanceVerifyingDouble: ' \
            '{"bar"=>["baz", "bax"], "mambo"=>["jambo", nil]}'
          )
        subject
      end
    end
  end
end
