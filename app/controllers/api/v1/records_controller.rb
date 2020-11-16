module Api
  module V1
    class RecordsController < ApplicationController
      before_action :authorize_access_request!
      before_action :set_user_track
      before_action :set_user_track_record, only: [:show, :update, :destroy]

      # GET /users/:user_id/tracks/:track_id/track/records
      def index
        json_response(@track.records)
      end

      # GET /users/:user_id/tracks/:track_id/records/:id
      def show
        json_response(@record)
      end

      # POST /users/:user_id/tracks/:track_id/records/
      def create
        @track.records.create!(record_params)
        json_response(@track, :created)
      end

      # PUT /users/:user_id/tracks/:track_id/records/:id
      def update
        @record.update(record_params)
        head :no_content
      end

      # DELETE /users/:user_id/tracks/:track_id/records/:id
      def destroy
        @record.destroy
        head :no_content
      end

      private

      def record_params
        params.permit(:value)
      end

      def set_user_track
        @track = current_user.tracks.find(params[:track_id]) if current_user
      end

      def set_user_track_record
        @record = @track.records.find_by!(id: params[:id]) if @track
      end
    end
  end
end