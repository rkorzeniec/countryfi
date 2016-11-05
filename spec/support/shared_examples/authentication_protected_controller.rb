#request[0] method (:get, :post...)
#request[1] action (:create, :index ...)
#request[2] params (e.g. {:id=>"1"})
shared_examples "an authentication protected controller" do |requests|
  context "a not signed in user" do
    requests.each do |request|
      it "has no access to #{request[0].upcase}##{request[1]}" do
        send(request[0], request[1], request[2])
        expect(response.status).to eq(302)
      end
    end
  end
end
