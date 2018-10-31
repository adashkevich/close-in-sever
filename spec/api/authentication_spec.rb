require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  let(:user) { Fabricate(:user, password: 'Pa$$w0rD') }
  let(:url) { '/login' }
  let(:params) do
    {
      user: {
        country_code: user.country_code,
        phone: user.phone,
        password: 'Pa$$w0rD'
      }
    }
  end

  path '/login' do
    post 'Authentication' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          country_code: { type: :string },
          phone: { type: :string },
          password: { type: :string }
        },
        required: %w[country_code phone password]
      }

      response '200', 'Successfully authenticated' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 country_code: { type: :string },
                 phone: { type: :string },
                 name: { type: :string }
               },
               required: %w[id country_code phone name]

        before do
          post url, params: params
        end

        it 'returns 200' do
          expect(response).to have_http_status(200)
        end
      end

      response '401', 'Authentication failed' do
        schema type: :string, enum: ['Invalid Country code, Phone or password.']

        before do
          post url
        end

        it 'returns 401' do
          expect(response).to have_http_status(401)
        end
      end
    end
  end

  context 'when params are correct' do
    # before do
    #   post url, params: params
    # end
    #
    # it 'returns 200' do
    #   expect(response).to have_http_status(200)
    # end

    # it 'returns JTW token in authorization header' do
    #   expect(response.headers['Authorization']).to be_present
    # end
    #
    # it 'returns valid JWT token' do
    #   decoded_token = decoded_jwt_token_from_response(response)
    #   expect(decoded_token.first['sub']).to be_present
    # end
  end

  # context 'when login params are incorrect' do
  #   before { post url }
  #
  #   it 'returns unathorized status' do
  #     expect(response.status).to eq 401
  #   end
  # end
end
#
# RSpec.describe 'DELETE /logout', type: :request do
#   let(:url) { '/logout' }
#
#   it 'returns 204, no content' do
#     delete url
#     expect(response).to have_http_status(204)
#   end
# end
