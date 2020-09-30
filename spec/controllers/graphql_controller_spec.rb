# frozen_string_literal: true

describe GraphqlController do
  subject { post(:execute, params: { query: query, variables: variables }) }

  let(:query) { '' }
  let(:variables) { {} }
  let(:headers) { {} }

  describe 'POST #execute' do
    context 'skips authentication' do
      it { expect(subject).to be_successful }
    end

    context 'with happy path' do
      context 'with valid query' do
        let(:user) { create(:user) }
        let(:token) do
          JwtToken.token({ user_id: user.id, jti_token: user.jti_token })
        end
        let(:query) do
          %(query {
            me {
              id,
              email
            }
          })
        end

        before { request.headers['Authorization'] = token }

        it do
          subject
          expect(JSON.parse(response.body)).to eq(
            'data' => { 'me' => { 'email' => user.email, 'id' => user.id.to_s } }
          )
        end

        context 'with variables' do
          let(:schema_hash) do
            {
              variables: parsed_variables,
              context: { current_user: user },
              operation_name: nil
            }
          end

          context 'when string' do
            context 'when empty' do
              let(:variables) { '' }
              let(:parsed_variables) { {} }

              it do
                expect(CountryfierSchema).to receive(:execute).with(
                  query, schema_hash
                )
                subject
              end
            end

            context 'when parsable' do
              let(:variables) { '{ "foo": {} }' }
              let(:parsed_variables) { { 'foo' => {} } }

              it do
                expect(CountryfierSchema).to receive(:execute).with(
                  query, schema_hash
                )
                subject
              end
            end

            context 'when unparsable' do
              let(:variables) { '1 2 3' }
              let(:parsed_variables) { {} }

              it { expect { subject }.to raise_error(JSON::ParserError) }
            end
          end

          context 'when hash' do
            # rubocop:disable Style/EmptyLiteral
            let(:variables) { Hash.new }
            let(:parsed_variables) { {} }
            # rubocop:enable Style/EmptyLiteral

            it do
              expect(CountryfierSchema).to receive(:execute).with(
                query, schema_hash
              )
              subject
            end
          end

          context 'when params' do
            let(:variables) { { foo: :bar } }
            let(:parsed_variables) { ActionController::Parameters.new(foo: 'bar') }

            it do
              expect(CountryfierSchema).to receive(:execute).with(
                query, schema_hash
              )
              subject
            end
          end

          context 'when nil' do
            let(:variables) { nil }
            let(:parsed_variables) { {} }

            it do
              expect(CountryfierSchema).to receive(:execute).with(
                query, schema_hash
              )
              subject
            end
          end

          context 'when other' do
            let(:variables) { 1234 }
            let(:parsed_variables) { ActionController::Parameters.new(foo: 'bar') }

            it do
              expect { subject }.to raise_error(
                ArgumentError, 'Unexpected parameter: 1234'
              )
            end
          end
        end
      end

      context 'with empty query' do
        it do
          subject
          expect(JSON.parse(response.body)).to eq(
            'errors' => [
              { 'locations' => [], 'message' => 'Unexpected end of document' }
            ]
          )
        end
      end
    end

    context 'when exception raised' do
      let(:error) { StandardError.new('GraphQL test error') }

      before do
        expect(CountryfierSchema).to receive(:execute).and_raise(error)
        allow(error).to receive(:backtrace).and_return([])
      end

      context 'when in dev env' do
        before do
          allow(Rails.env).to receive(:development?).and_return(true)
        end

        it 'handles error' do
          subject
          expect(JSON.parse(response.body)).to eq(
            'data' => {},
            'error' => {
              'backtrace' => [],
              'message' => 'GraphQL test error'
            }
          )
        end
      end

      context 'when in production env' do
        before { allow(Rails.env).to receive(:development?).and_return(false) }

        it { expect { subject }.to raise_error(StandardError) }
      end
    end
  end
end
