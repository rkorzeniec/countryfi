# frozen_string_literal: true

RSpec.describe Mutations::Signup do
  subject { CountryfierSchema.execute(query).as_json }

  let(:query) do
    %(mutation {
      signup(
        email: "#{email}",
        password: "#{password}",
        passwordConfirmation: "#{password_confirmation}"
      ) {
        token
        user {
          email
        }
      }
    })
  end

  context 'when successful' do
    let(:email) { 'john@email.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    it do
      expect { subject }.to change(User, :count).from(0).to(1)
    end
  end

  context 'with user exists' do
    let!(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { user.password }
    let(:password_confirmation) { user.password }

    it do
      expect(subject).to include(
        'data' => { 'signup' => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => 'Email has already been taken',
            'path' => ['signup']
          }
        ]
      )
    end
  end

  context 'with incorrect email' do
    let(:email) { 'johnemail.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    it do
      expect(subject).to include(
        'data' => { 'signup' => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => 'Email is invalid',
            'path' => ['signup']
          }
        ]
      )
    end
  end

  context 'with passwords do not match' do
    let(:email) { 'john@email.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password2' }

    it do
      expect(subject).to include(
        'data' => { 'signup' => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => "Password confirmation doesn't match Password",
            'path' => ['signup']
          }
        ]
      )
    end
  end

  context 'with too short password' do
    let(:email) { 'john@email.com' }
    let(:password) { 'pass' }
    let(:password_confirmation) { 'pass' }

    it do
      expect(subject).to include(
        'data' => { 'signup' => nil },
        'errors' => [
          {
            'locations' => [{ 'column' => 7, 'line' => 2 }],
            'message' => 'Password is too short (minimum is 8 characters)',
            'path' => ['signup']
          }
        ]
      )
    end
  end

  context 'with incorrect params' do
    let(:query) do
      %(mutation {
        signup(
          email: "john@email.com",
          password: "password",
          passwordConfirmation: "password",
          mambo: "jambo"
        ) {
          token
          user {
            email
          }
        }
      })
    end

    it do
      expect(subject).to eq(
        'errors' => [
          {
            'extensions' => {
              'argumentName' => 'mambo',
              'code' => 'argumentNotAccepted',
              'name' => 'signup',
              'typeName' => 'Field'
            },
            'locations' => [{ 'column' => 11, 'line' => 6 }],
            'message' => "Field 'signup' doesn't accept argument 'mambo'",
            'path' => %w[mutation signup mambo]
          }
        ]
      )
    end
  end
end
