# frozen_string_literal: true

describe SentryJob, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  describe '.perform' do
    it do
      expect { described_class.perform_later('event') }
        .to have_enqueued_job
        .on_queue('default')
        .at(:no_wait)
    end

    it do
      expect(Raven).to receive(:send_event).with('event')
      described_class.perform_now('event')
    end
  end
end
