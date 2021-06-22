# frozen_string_literal: true

shared_examples 'authentication_protected_controller' do |requests|
  context 'when user not signed in user' do
    requests.each do |request|
      it "has no access to #{request[0].upcase}##{request[1]}" do
        send(request[0], *request[1], **request[2])
        expect(response.status).to eq(302)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
