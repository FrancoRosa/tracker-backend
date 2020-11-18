
class SigninController < ApplicationController
  before_action :autorize_access_request!, only: [:destroy]
  def create
    user = User.find_by(email: user_params[:email])
    if user.nil?
      not_found
    elsif user.authenticate(user_params[:password])
      token = JWT.encode({user_id: user.id}, 'secret')
      render json: { token: token }
    else
      wrong_password
    end
  end

  def destroy
    render json: :ok
  end

  private

  def wrong_password
    render json: { error: 'Wrong password'}, status: :not_found
  end

  def not_found
    render json: { error: 'Can not find user with requested email' }, status: :not_found
  end

  def user_params
    puts params.inspect
    params.require(:user).permit(:email, :password)
  end
end