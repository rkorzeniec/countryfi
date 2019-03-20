describe PreferencesController do
  let(:user) { create(:user) }

  context 'when user not authenticated' do
    it_behaves_like 'authentication_protected_controller', [
      [:get, :edit, params: { id: 1 }],
      [:put, :update, params: { id: 1 }]
    ]
  end

  context 'when user signed in' do
    before { sign_in(user) }

    describe 'GET edit' do
      before { get(:edit, params: { user: { color: 'some_colour' } }) }

      it do
        expect(response).to be_successful
        expect(subject).to render_template(:edit)
      end
    end

    describe 'PUT update' do
      let!(:now) { '2016-01-01' }

      subject { post(:update, params: params) }

      context 'when successful' do
        let(:params) { { user: { color: 'some_colour' } } }

        it do
          expect(subject).to redirect_to(edit_preferences_path)
          expect(flash[:success]).to be_present
        end
        it do
          expect { subject }.to change { user.reload.color }
            .from(nil).to('some_colour')
        end
      end

      context 'when unsuccessful' do
        let(:params) { { user: { color: 'some_colour' } } }

        before do
          allow_any_instance_of(User).to receive(:update_attributes)
            .and_return(false)
        end

        it do
          expect(subject).to render_template(:edit)
          expect(flash[:error]).to be_present
        end
      end
    end
  end
end
