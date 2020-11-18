class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  @api_key = ENV['api_key']

  private

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
