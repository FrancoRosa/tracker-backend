require 'rails_helper'

RSpec.describe "Records", type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:track) { create(:track, user_id: user.id) }
  let!(:records) { create_list(:record, 20, track_id: track.id) }
  let(:user_id) { user.id }
  let(:track_id) { track.id }
  let(:id) { records.first.id }
  # Test suite for GET /users/:user_id/tracks/:track_id/records
  describe 'GET /users/:user_id/tracks/:track_id/records' do
    before { get "/users/#{user_id}/tracks/#{track_id}/records" }

    context 'when records exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all track records' do
        expect(json.size).to eq(20)
      end
    end

    context 'when track does not exist' do
      let(:track_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Track/)
      end
    end
  end

  # Test suite for GET /users/:user_id/tracks/:track_id/records/:id
  describe 'GET /users/:user_id/tracks/:track_id/records/:id' do
    before { get "/users/#{user_id}/tracks/#{track_id}/records/#{id}" }

    context 'when track record exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the track' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when track record does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Record/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/tracks/:track_id/records/:id
  describe 'POST /users/:user_id/tracks/:track_id/records' do
    let(:valid_attributes) { { value: 1234 } }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/tracks/#{track_id}/records", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/tracks/#{track_id}/records", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Value can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/tracks/:track_id/records/:id
  describe 'PUT /users/:user_id/tracks/:track_id/records/:id' do
    let(:valid_attributes) { { value: 13.12 } }

    before { put "/users/#{user_id}/tracks/#{track_id}/records/#{id}", params: valid_attributes }

    context 'when track exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the track' do
        updated_record = Track.find(track_id).records.find(id)
        expect(updated_record.value).to match(13.12)
      end
    end

    context 'when the record does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Record/)
      end
    end
  end

  # Test suite for DELETE /users/:user_id/tracks/:track_id/records/:id
  describe 'DELETE /users/:user_id/tracks/:track_id/records/:id' do
    before { delete "/users/#{user_id}/tracks/#{track_id}/records/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
