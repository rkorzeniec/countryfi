RSpec.describe Mutations::AddCheckin do
  let(:schema_hash) { {} }
  let(:country) { create(:country) }
  let(:checkin_date) { '2019-05-02' }
  let(:query) do
    %(mutation {
      addCheckin(countryId: #{country.id}, checkinDate: "#{checkin_date}") {
        checkin {
          country { nameCommon }
        }
      }
    })
  end

  subject { CountryfierSchema.execute(query, schema_hash).as_json }

  it_behaves_like 'unathorized_api_request' do
    let(:request) { 'addCheckin' }
  end

  it_behaves_like 'incorrect_params_api_request' do
    let(:request) { 'signin' }
    let(:query) do
      %(mutation {
        addCheckin(countryId: 1, checkinDate: 2019-01-01, mambo: "jambo") {
          checkin {
            country { nameCommon }
          }
        }
      })
    end
  end

  context 'when user authenticated' do
    let(:user) { create(:user) }
    let(:schema_hash) { { context: { current_user: user } } }

    it do
      is_expected.to eq(
        'data' => {
          'addCheckin' => {
            'checkin' => { 'country' => { 'nameCommon' => 'Switzerland' } }
          }
        }
      )
    end

    it { expect { subject }.to change { Checkin.count }.from(0).to(1) }

    context 'with non existent country' do
      let(:country) { double('country', id: 0) }

      it do
        is_expected.to eq(
          'data' => { 'addCheckin' => nil },
          'errors' => [
            {
              'locations' => [{ 'column' => 7, 'line' => 2 }],
              'message' => "Country can't be blank",
              'path' => ['addCheckin']
            }
          ]
        )
      end
    end

    context 'with incorrent date' do
      let(:checkin_date) { 'not-a-date' }

      it do
        is_expected.to eq(
          'data' => { 'addCheckin' => nil },
          'errors' => [
            {
              'locations' => [{ 'column' => 7, 'line' => 2 }],
              'message' => "Checkin date can't be blank",
              'path' => ['addCheckin']
            }
          ]
        )
      end
    end
  end
end
