class SigninController < ApplicationController
  before_action :autorize_access_request!, only: [:destroy]
  def create
    user = User.find_by(email: user_params[:email])
    if user.nil?
      not_found
    elsif user.authenticate(user_params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie,
                          value: tokens[:access],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: { crsf: tokens[:crsf] }
    else
      wrong_password
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def wrong_password
    render json: { error: 'Wrong password'}, status: :not_found
  end

  def not_found
    render json: { error: 'Can not find user with requested email'}, status: :not_found
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
  
end