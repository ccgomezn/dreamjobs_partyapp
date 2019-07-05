# frozen_string_literal: true

class UserController < ApplicationController
  before_action :authenticate_user, only: [:destroy, :update, :index, :show, :desactivate_user]
  before_action :check_admin, only: [:destroy, :update, :index, :show, :desactivate_user]


  def destroy
    User.find(params[:id]).destroy!

    render json: {message: 'User destroyed'}, status: :ok
  end

  def update
    user = User.find(params[:id])

    user.update(user_params)
    render json: {message: 'User edited', data: user.as_json(:except => [:password_digest])}, status: :ok
  end

  def index
    users = User.all.select(User.attribute_names - ['password_digest'])

    render json: users.as_json, status: :ok
  end

  def show
    user = User.find(params[:id])

    render json: user.as_json(:except => [:password_digest]), status: :ok
  end

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

  def desactivate_user
    user = User.find_by(user_token: params[:id])
    if user
      user.user_desactivate
      render json: {message: 'User desactivaded'}, status: :ok
    else
      render json: {message: 'User not desactivaded'}, status: 403
    end
  end
  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :national_id, :email,
                                 :password, :user_type)
  end
end
