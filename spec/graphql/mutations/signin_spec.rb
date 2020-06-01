# frozen_string_literal: true
RSpec.describe Mutations::Signin, type: :request do
  subject { CountryfierSchema.execute(query).as_json }

  let(:query) do
    %(mutation {
      signin(email: "#{email}", password: "#{password}") {
        token
        user {
          email
        }
      }
    })
  end

  it_behaves_like 'incorrect_params_api_request' do
    let(:request) { 'signin' }
    let(:location) { 63 }
    let(:query) do
      %(mutation {
        signin(email: "john@email.com", password: "password", mambo: "jambo") {
          token
          user {
            email
          }
        }
      })
    end
  end

  context 'with existing user' do
    let!(:user) { create(:user) }
    let(:email) { user.email }

    context 'when successful' do
      let(:password) { user.password }
      let(:token) { JwtToken.token(user_id: user.id, jti: user.jti_token) }

      it do
        expect(subject).to eq(
          'data' => {
            'signin' => {
              'token' => token, 'user' => { 'email' => user.email }
            }
          }
        )
      end
    end

    context 'when unsuccessful' do
      let(:password) { 'john' }

      it do
        subject
        expect(subject).to eq(
          'data' => { 'signin' => nil },
          'errors' => [
            {
              'locations' => [{ 'column' => 7, 'line' => 2 }],
              'message' => 'Invalid login details.',
              'path' => ['signin']
            }
          ]
        )
      end
    end
  end

  context 'with non-existing user' do
    let(:email) { 'john@email.com' }
    let(:password) { 'john' }

    it do
      subject
      expect(subject).to eq(
        'data' => { 'signin' => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => 'Invalid login details.',
            'path' => ['signin']
          }
        ]
      )
    end
  end
end
