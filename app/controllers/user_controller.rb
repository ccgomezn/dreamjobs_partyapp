# frozen_string_literal: true

class UserController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      UserMailer.registration_confirmation(user).deliver

      render json: {message: 'Please confirm your user email'}, status: :created
    else
      render json: { error: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def confirm_email
    user = User.find_by(user_token: params[:id])
    if user
      user.user_activate
      render json: {message: 'User activated'}, status: :ok
    else
      render json: {message: 'User not activated'}, status: 403
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :national_id, :email,
                                 :password, :user_type)
  end
end
