require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
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

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'returns a new user' do
      #TODO match with json
      #expect(response.body).to match_user('user')
    end
  end

  context 'when user already exists' do
    before do
      #Fabricate :user, email: params[:user][:email]
      post url, params: params
    end

    it 'returns bad request status' do
      expect(response.status).to eq 400
    end

    it 'returns validation errors' do
      json = JSON.parse(response.body)
      expect(json['errors'].first['title']).to eq('Bad Request')
    end
  end
end
