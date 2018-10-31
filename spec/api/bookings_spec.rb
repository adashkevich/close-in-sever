require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Bookings API', type: :request do

  let(:user) { Fabricate(:user) }
  let(:event) { Fabricate(:event) { organizer { user } } }
  let(:url) { '/bookings' }

  before do
    post '/login', params: user.as_json(root: true, only: %w[country_code phone password], methods: :password)
    @jwt = response.headers['Authorization']
  end

  path '/bookings' do
    post 'Create booking' do
      tags 'Bookings'
      consumes 'application/json'
      parameter name: :booking, in: :body, schema: {
        type: :object,
        properties: {
          event_id: { type: :integer, example: 87_362 },
          booking: {
            type: :object,
            properties: {
              count: { type: :integer, example: 3 },
              required: %w[count]
            }
          },
          required: %w[event_id booking]
        }
      }

      response '201', 'Successfully created' do

        before do
          #post url, params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 201' do
          #expect(response.status).to eq 201
        end
      end
    end

    get 'Get bookings' do
      tags 'Bookings'
      consumes 'application/json'

      response '200', 'Successfully get' do
        schema type: :array,
               items: {
                   type: :object,
                   properties: {
                       id: { type: :integer, example: 27 },
                       user_id: { type: :integer, example: 735 },
                       event_id: { type: :integer, example: 87_362 },
                       count: { type: :integer, example: 3 },
                   },
                   required: %w[id user_id event_id count]
               }

        before do
          #post url, params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 201' do
          #expect(response.status).to eq 201
        end
      end
    end
  end

  path '/bookings/{id}' do

    delete 'Delete booking' do
      tags 'Bookings'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer, example: 35

      response '204', 'Successfully delete' do

        before do
          #post "events/#{@event_id}", params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 204' do
          #expect(response.status).to eq 204
        end
      end
    end
  end
end
