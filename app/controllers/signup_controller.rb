class SignupController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      token = JWT.encode({ user_id: user.id }, 'secret')
      render json: { token: token }
    else
      render json: { error: user.errors.full_messages.join('') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
