require 'swagger_helper'

RSpec.describe 'Auth API', type: :request do
  let(:url) { '/signup' }
  #let(:user) { Fabricator(:user) }
  let(:params) do
    {
      user: {
        name: Faker::FunnyName.name,
        country_code: '+375',
        phone: Faker::Number.number(7).to_s,
        password: Faker::Internet.password
      }
    }
  end

  # context 'when user is unauthenticated' do
  #   before { post url, params: params }
  #
  #   it 'returns 200' do
  #     expect(response.status).to eq 200
  #   end
  #
  #   it 'returns a new user' do
  #     #TODO match with json
  #     #expect(response.body).to match_user('user')
  #   end
  # end
  #
  # context 'when user already exists' do
  #   before do
  #     #Fabricate :user, email: params[:user][:email]
  #     post url, params: params
  #   end
  #
  #   it 'returns bad request status' do
  #     expect(response.status).to eq 400
  #   end
  #
  #   it 'returns validation errors' do
  #     json = JSON.parse(response.body)
  #     expect(json['errors'].first['title']).to eq('Bad Request')
  #   end
  # end


  path '/signup' do
    post 'Registration' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
              country_code: { type: :string, examle: '+375' },
              phone: { type: :string, examle: '297654321' },
              name: { type: :string, examle: 'John Doe' },
              password: { type: :string, examle: 'Pa$$w0rD!' }
          },
          required: [ 'country_code', 'phone', 'name', 'password' ]
      }

      response '200', 'Successfully registered' do
        schema type: :object,
               properties: {
                   id: { type: :integer, example: 735 },
                   country_code: { type: :string, examle: '+375' },
                   phone: { type: :string, examle: '297654321' },
                   name: { type: :string, examle: 'John Doe' }
               },
               required: [ 'id', 'country_code', 'phone', 'name' ]

        before { post url, params: params }

        it 'returns 200' do
          expect(response.status).to eq 200
        end
      end

      response '400', 'Registration failed' do
        schema type: :string, enum: ['Invalid Country code, Phone or password.']

        before do
          post url
        end

        it 'returns 400' do
          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
