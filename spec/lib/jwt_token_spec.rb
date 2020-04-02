describe JwtToken do
  let(:now) { Time.current }
  let(:secret) { Rails.application.secrets.jwt_secret_key_base.to_s }

  before { Timecop.freeze(now) }

  after { Timecop.return }

  describe '#token' do
    subject { described_class.token(payload) }

    let(:user) { instance_double('user', id: 99) }
    let(:payload) { { user_id: user.id } }

    it do
      expect(JWT).to receive(:encode)
        .with({ user_id: user.id, 'iat' => now.to_i }, secret)
        .and_return('token')

      expect(subject).to eq('token')
    end
  end

  describe '#decode' do
    subject { described_class.decode(token) }

    let(:user) { instance_double('user', id: 99) }
    let(:token) { described_class.token(user_id: user.id) }

    it do
      expect(JWT).to receive(:decode)
        .with(token, secret)
        .and_call_original
      expect(subject).to eq('user_id' => user.id, 'iat' => now.to_i)
    end
  end
end
