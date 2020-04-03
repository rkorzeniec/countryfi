describe Graphql::Authenticator do
  let(:authenticator) { described_class.new(token) }

  describe '#call' do
    subject { authenticator.call }

    let(:user) { create(:user) }

    context 'without token' do
      let(:token) { '' }

      it { is_expected.to be_nil }
    end

    context 'when correct token' do
      let(:token) { JwtToken.token(user_id: user.id, jti_token: user.jti_token) }

      it { is_expected.to eq(user) }
    end

    context 'when incorrect token' do
      let(:token) { JwtToken.token(user_id: user.id, jti_token: 'not_a_jti') }

      it { is_expected.to be_nil }
    end
  end
end
