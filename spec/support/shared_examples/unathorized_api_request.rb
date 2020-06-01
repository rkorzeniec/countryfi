# frozen_string_literal: true

shared_examples 'unathorized_api_request' do
  context 'when no user credentials are given' do
    let(:headers) { {} }

    it do
      expect(subject).to eq(
        'data' => { request.to_s => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => 'Authentication required',
            'path' => %W[#{request}]
          }
        ]
      )
    end
  end
end
