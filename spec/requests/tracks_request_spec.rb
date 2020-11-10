require 'rails_helper'

RSpec.describe "Tracks", type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:tracks) { create_list(:track, 20, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { tracks.first.id }
  # Test suite for GET /users/:user_id/tracks
  describe 'GET /users/:user_id/tracks' do
    before { get "/users/#{user_id}/tracks" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user tracks' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/tracks/:id
  describe 'GET /users/:user_id/tracks/:id' do
    before { get "/users/#{user_id}/tracks/#{id}" }

    context 'when user track exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/tracks
  describe 'POST /users/:user_id/tracks' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/tracks", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/tracks", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/tracks/:id
  describe 'PUT /users/:user_id/tracks/:id' do
    let(:valid_attributes) { { name: 'Mozart' } }

    before { put "/users/#{user_id}/tracks/#{id}", params: valid_attributes }

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_track = Track.find(id)
        expect(updated_track.name).to match(/Mozart/)
      end
    end

    context 'when the track does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/tracks/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
