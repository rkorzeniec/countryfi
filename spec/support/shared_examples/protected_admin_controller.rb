shared_examples 'protected_admin_controller' do |requests|
  context 'a user signed in' do
    let(:user) { create(:user) }

    before { sign_in(user) }

    requests.each do |request|
      it "has no access to #{request[0].upcase}##{request[1]}" do
        send(request[0], request[1], request[2])
        expect(response.status).to eq(302)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end

  context 'a user not signed in' do
    requests.each do |request|
      it "has no access to #{request[0].upcase}##{request[1]}" do
        send(request[0], request[1], request[2])
        expect(response.status).to eq(302)
        expect(response).to redirect_to(dashboard_path)
      end
    end
  end
end
