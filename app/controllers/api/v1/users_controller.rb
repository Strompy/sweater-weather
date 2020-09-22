class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      errors = user.errors.full_messages.to_sentence
      status = errors.include?('taken') ? :forbidden : :conflict
      render json: { errors: errors }, status: status
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
