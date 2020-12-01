module Api
  module V1
    class RecordsController < ApplicationController
      before_action :set_user
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

      # POST /users/tracks/:track_id/records/
      def create
        @record = @track.records.new(value: record_params[:value], user_id: @user.id)
        if @record.save
          records = @track.records.select(:id, :value, :created_at)
          update_track
          json_response(records)
        else
          render json: { error: record.errors.full_messages.join(', ') }
        end
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
        params.require(:record).permit(:value)
      end

      def set_user_track
        @track = Track.find(params[:track_id]) if @user
      end

      def set_user_track_record
        @record = @track.records.find_by!(id: params[:id]) if @track
      end

      def update_track
        @record.track.update(last_record: @record.value)
      end

    end
  end
end
