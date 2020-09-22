class Api::V1::SessionsController < ApplicationController
  def create
    require "pry"; binding.pry
    user = User.find_by(email: params[:email])
    if user.nil?
      # render no email error
    elsif user.authenticate(params[:password])
      # create session?
      render json: UserSerializer.new(user)
    else
      # render password error
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
