module Api
  module V1
    class TracksController < ApplicationController
      before_action :set_user
      before_action :set_user_track, only: [:show, :update, :destroy]
      # GET /users/:user_id/tracks
      def index
        json_response(@user.tracks)
      end

      # GET /users/:user_id/tracks/:id
      def show
        json_response(@track)
      end

      # POST /users/:user_id/tracks
      def create
        track = @user.tracks.create!(name: track_params[:name])
        json_response({ track_id: track.id }, :created)
      end

      # PUT /users/:user_id/tracks/:id
      def update
        @track.update(name: track_params[:name])
        head :no_content
      end

      # DELETE /users/:user_id/tracks/:id
      def destroy
        @track.destroy
        head :no_content
      end

      private

      def track_params
        params.require(:track).permit(:name, :token, :id)
      end

      def set_user_track
        @track = @user.tracks.find_by!(id: track_params[:id]) if @user
      end

      def set_user
        decoded = JWT.decode(track_params[:token], ENV['api_key'])[0]
        tokentime = decoded['time']
        user_id = decoded['user_id']
        time = Time.now.to_i
        render json: { message: 'token expired' } if (time - tokentime) > 300
        @user = User.find(user_id)
      end
    end
  end
end
