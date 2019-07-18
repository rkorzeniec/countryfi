module Mutations
  class Signup < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true
    argument :password_confirmation, String, required: true

    field :token, String, null: false
    field :user, Types::UserType, null: false

    def resolve(params)
      user = User.new(params)
      if user.save
        token = JwtToken.token(user_id: user.id, jti: user.jti_token)
        { user: user, token: token }
      else
        GraphQL::ExecutionError.new(user.errors.full_messages.to_sentence)
      end
    end
  end
end
