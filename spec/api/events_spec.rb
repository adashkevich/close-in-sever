require 'swagger_helper'

RSpec.describe 'Events API', type: :request do

  let(:user) { Fabricate(:user) }
  let(:event) { { event: Fabricate.attributes_for(:event) } }
  let(:url) { '/events' }

  before do
    post '/login', params: user.as_json(root: true, only: %w[country_code phone password], methods: :password)
    @jwt = response.headers['Authorization']
  end

  path '/events' do
    post 'Create event' do
      tags 'Events'
      consumes 'application/json'
      parameter name: :event, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string, example: 'Friendly Match' },
          category: { type: :string, enum: %w[other meeting football basketball volleyball freewalkingtours], example: 'football' },
          start_time: { type: :string, example: '2020-10-07T17:00' },
          ent_time: { type: :string, example: '2018-10-07T18:30' },
          cost: { type: :number, example: 6.5, default: nil },
          capacity: { type: :integer, example: 15, default: nil },
          location: { type: :string, example: 'POINT(114.2219923 22.3129115)' }
        },
        required: %w[title category start_time ent_time location]
      }

      response '200', 'Successfully created' do
        schema type: :object,
               properties: {
                 id: { type: :integer, example: 87_362 },
                 title: { type: :string, example: 'Friendly Match' },
                 category: { type: :string, enum: %w[other meeting football basketball volleyball freewalkingtours], example: 'football' },
                 start_time: { type: :string, example: '2020-10-07T17:00' },
                 ent_time: { type: :string, example: '2018-10-07T18:30' },
                 cost: { type: :number, example: 6.5, default: nil },
                 capacity: { type: :integer, example: 15, default: nil },
                 location: { type: :string, example: 'POINT(114.2219923 22.3129115)' }
               },
               required: %w[id title category start_time ent_time location]

        before do
          post url, params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 201' do
          expect(response.status).to eq 201
          body = JSON.parse(response.body)
          @event_id = body.id
        end
      end
    end

    get 'Get events' do
      tags 'Events'
      consumes 'application/json'
      parameter name: :date,
                in: :query,
                type: :string,
                required: true,
                example: '2020-10-07',
                description: 'Date which events getting for'

      parameter name: :area,
                in: :query,
                type: :string,
                required: true,
                example: 'ST_MakeEnvelope(114.3, 22.4, 114.1, 22.2)',
                description: 'Area in PostGis format which events getting for'

      response '200', 'Successfully get' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer, example: 87362 },
                   title: { type: :string, example: 'Friendly Match' },
                   category: { type: :string, enum: %w[other meeting football basketball volleyball freewalkingtours], example: 'football' },
                   start_time: { type: :string, example: '2020-10-07T17:00' },
                   ent_time: { type: :string, example: '2018-10-07T18:30' },
                   cost: { type: :number, example: 6.5, default: nil },
                   capacity: { type: :integer, example: 15, default: nil },
                   location: { type: :string, example: 'POINT(114.2219923 22.3129115)' }
                 },
                 required: %w[id title category start_time ent_time location]
               }

        before do
          post url, params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 201' do
          #expect(response.status).to eq 201
        end
      end
    end
  end

  path '/events/participate' do

    get 'Get participate events' do
      tags 'Events'
      consumes 'application/json'

      response '200', 'Successfully get' do
        schema type: :array,
               items: {
                   type: :object,
                   properties: {
                       id: { type: :integer, example: 87362 },
                       title: { type: :string, example: 'Friendly Match' },
                       category: { type: :string, enum: %w[other meeting football basketball volleyball freewalkingtours], example: 'football' },
                       start_time: { type: :string, example: '2020-10-07T17:00' },
                       ent_time: { type: :string, example: '2018-10-07T18:30' },
                       cost: { type: :number, example: 6.5, default: nil },
                       capacity: { type: :integer, example: 15, default: nil },
                       location: { type: :string, example: 'POINT(114.2219923 22.3129115)' }
                   },
                   required: %w[id title category start_time ent_time location]
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

  path '/events/organize' do

    get 'Get organize events' do
      tags 'Events'
      consumes 'application/json'

      response '200', 'Successfully get' do
        schema type: :array,
               items: {
                   type: :object,
                   properties: {
                       id: { type: :integer, example: 87362 },
                       title: { type: :string, example: 'Friendly Match' },
                       category: { type: :string, enum: %w[other meeting football basketball volleyball freewalkingtours], example: 'football' },
                       start_time: { type: :string, example: '2020-10-07T17:00' },
                       ent_time: { type: :string, example: '2018-10-07T18:30' },
                       cost: { type: :number, example: 6.5, default: nil },
                       capacity: { type: :integer, example: 15, default: nil },
                       location: { type: :string, example: 'POINT(114.2219923 22.3129115)' }
                   },
                   required: %w[id title category start_time ent_time location]
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

  path '/events/{id}' do

    delete 'Delete event' do
      tags 'Events'
      consumes 'application/json'
      parameter name: :id,
                in: :path,
                type: :integer,
                required: true,
                example: 87_362,
                description: 'Id of event to delete'

      response '204', 'Successfully delete' do

        before do
          post "events/#{@event_id}", params: event.as_json, headers: { 'Authorization' => @jwt }
        end

        it 'returns 201' do
          expect(response.status).to eq 204
        end
      end
    end
  end
end
