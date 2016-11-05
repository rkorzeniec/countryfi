shared_examples 'protected admin controller' do |requests|
  context 'a signed in user' do
    requests.each do |request|
      it "has no access to #{request[0].upcase}##{request[1]}" do
        send(request[0], request[1], request[2])
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
