describe JwtToken do
  let(:now) { Time.current }
  let(:secret) { Rails.application.secrets.jwt_secret_key_base.to_s }

  before { Timecop.freeze(now) }

  after { Timecop.return }

  describe '#token' do
    let(:user) { double('user', id: 99) }
    let(:payload) { { user_id: user.id } }

    subject { described_class.token(payload) }

    it do
      expect(JWT).to receive(:encode)
        .with({ user_id: user.id, 'iat' => now.to_i }, secret)
        .and_return('token')

      is_expected.to eq('token')
    end
  end

  describe '#decode' do
    let(:user) { double('user', id: 99) }
    let(:token) { JwtToken.token(user_id: user.id) }

    subject { described_class.decode(token) }

    it do
      expect(JWT).to receive(:decode)
        .with(token, secret)
        .and_call_original
      is_expected.to eq('user_id' => user.id, 'iat' => now.to_i)
    end
  end
end
