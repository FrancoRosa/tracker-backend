module Api
  module V1
    class TracksController < ApplicationController
      before_action :set_user
      before_action :set_user_track, only: [:show, :update, :destroy]
      # GET /users/:user_id/tracks
      def index
        tracks = @user.tracks.all.pluck(:id, :name).map { |id, name| { id: id, name: name } }
        json_response(tracks)
      end

      # GET /users/:user_id/tracks/:id
      def show
        records = @track.records.pluck(:id, :value, :created_at).map do |id, value, created_at|
          { id: id, value: value, created_at: created_at }
        end
        json_response(records)
      end

      # POST /users/:user_id/tracks
      def create
        track = @user.tracks.new(name: track_params[:name])
        if track.save
          tracks = @user.tracks.pluck(:id, :name).map { |id, name| { id: id, name: name } }
          json_response(tracks)
        else
          render json: { error: track.errors.full_messages.join(', ') }
        end
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

        @track = @user.tracks.find_by!(id: params[:id]) if @user
      end

      def set_user
        decoded = JWT.decode(params[:token], ENV['api_key'])[0]
        tokentime = decoded['time']
        user_id = decoded['user_id']
        time = Time.now.to_i
        render json: { error: 'Token expired' } if (time - tokentime) > 300
        @user = User.find(user_id)
      end
    end
  end
end
