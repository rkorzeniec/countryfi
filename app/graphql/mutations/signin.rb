module Mutations
  class Signin < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(email:, password:)
      user = User.find_for_authentication(email: email)
      return error unless user&.valid_password?(password)

      token = JwtToken.token(user_id: user.id, jti: user.jti_token)
      { user: user, token: token }
    end

    private

    def error
      GraphQL::ExecutionError.new('Invalid login details.')
    end
  end
end
