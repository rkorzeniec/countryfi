# frozen_string_literal: true

describe Types::QueryType do
  subject { CountryfierSchema.execute(query, **schema_hash).as_json }

  let(:schema_hash) { {} }

  describe '#checkins' do
    let(:query) do
      %(query {
        checkins {
          id,
          checkinDate
          user { email }
          country { nameCommon }
        }
      })
    end

    context 'when unauthenticated user' do
      it do
        result = subject['errors']
        expect(result).to eq(
          [
            {
              'locations' => [{ 'column' => 9, 'line' => 2 }],
              'message' => 'Authentication required',
              'path' => ['checkins']
            }
          ]
        )
      end
    end

    context 'when authenticated user' do
      let(:schema_hash) { { context: { current_user: user } } }
      let(:user) { create(:user) }
      let!(:checkin) { create(:checkin, user: user) }
      let!(:checkin_b) { create(:checkin, :visited, user: user) }

      it do
        results = subject.dig('data', 'checkins')
        expect(results.size).to eq(2)
        expect(results.first).to eq(
          'id' => checkin.id.to_s,
          'checkinDate' => checkin.checkin_date.strftime('%F'),
          'country' => { 'nameCommon' => 'Switzerland' },
          'user' => { 'email' => checkin.user.email }
        )
      end
    end
  end

  describe '#me' do
    let(:query) do
      %(query {
        me {
          id,
          email
          checkins {
            id
            checkinDate
          }
          countries { nameCommon }
        }
      })
    end

    context 'when unauthenticated user' do
      it do
        result = subject['errors']
        expect(result).to eq(
          [
            {
              'locations' => [{ 'column' => 9, 'line' => 2 }],
              'message' => 'Authentication required',
              'path' => ['me']
            }
          ]
        )
      end
    end

    context 'when authenticated user' do
      let(:schema_hash) { { context: { current_user: user } } }
      let(:user) { create(:user) }
      let!(:checkin) { create(:checkin, user: user) }
      let!(:checkin_b) { create(:checkin) }

      it do
        result = subject.dig('data', 'me')
        expect(result).to eq(
          'id' => user.id.to_s,
          'email' => user.email,
          'countries' => [{ 'nameCommon' => 'Switzerland' }],
          'checkins' => [
            {
              'id' => checkin.id.to_s,
              'checkinDate' => checkin.checkin_date.strftime('%F')
            }
          ]
        )
      end
    end
  end
end
