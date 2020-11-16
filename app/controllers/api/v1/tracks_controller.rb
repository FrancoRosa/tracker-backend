module Api
  module V1
    class TracksController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user_track, only: [:show, :update, :destroy]

      # GET /users/:user_id/tracks
      def index
        json_response(current_user.tracks)
      end

      # GET /users/:user_id/tracks/:id
      def show
        json_response(@track)
      end

      # POST /users/:user_id/tracks
      def create
        current_user.tracks.create!(track_params)
        json_response(current_user, :created)
      end

      # PUT /users/:user_id/tracks/:id
      def update
        @track.update(track_params)
        head :no_content
      end

      # DELETE /users/:user_id/tracks/:id
      def destroy
        @track.destroy
        head :no_content
      end

      private

      def track_params
        params.permit(:name)
      end

      def set_user_track
        @track = current_user.tracks.find_by!(id: params[:id]) if current_user
      end
    end
  end 
end