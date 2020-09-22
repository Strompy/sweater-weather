class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user.nil?
      render json: { errors: 'Invalid email' }, status: :unauthorized
    elsif user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { errors: 'Incorrect password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
