class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  private

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
