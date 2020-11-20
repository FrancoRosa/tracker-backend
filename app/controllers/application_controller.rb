class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  @api_key = ENV['api_key']

  private

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end

  def set_user
    decoded = JWT.decode(params[:token], ENV['api_key'])[0]
    tokentime = decoded['time']
    user_id = decoded['user_id']
    time = Time.now.to_i
    render json: { error: 'Token expired' } if (time - tokentime) > 300
    @user = User.find(user_id)
    p '???????????????????????????'
  end
  
end
