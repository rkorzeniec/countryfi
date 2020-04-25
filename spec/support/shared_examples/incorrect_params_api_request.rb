shared_examples 'incorrect_params_api_request' do
  context 'with incorrect params' do
    it do
      subject
      expect(subject).to eq(
        'errors' => [
          {
            'extensions' => {
              'argumentName' => 'mambo',
              'code' => 'argumentNotAccepted',
              'name' => request,
              'typeName' => 'Field'
            },
            'locations' => [{ 'column' => location, 'line' => 2 }],
            'message' => "Field '#{request}' doesn't accept argument 'mambo'",
            'path' => %W[mutation #{request} mambo]
          }
        ]
      )
    end
  end
end
