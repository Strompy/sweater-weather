class Api::V1::UsersController < ApplicationController
  def create
    # require "pry"; binding.pry
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      errors = user.errors.full_messages.to_sentence
      render json: { errors: errors }, status: 400
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
