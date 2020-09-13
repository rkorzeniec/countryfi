# frozen_string_literal: true

describe Explore::BaseExploreController do
  describe '#index' do
    subject { controller.index }

    it { expect { subject }.to raise_error(NotImplementedError) }
  end
end
