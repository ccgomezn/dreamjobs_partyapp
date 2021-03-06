class ServiceController < ApplicationController
  before_action :authenticate_user
  before_action :check_admin, only: [:create, :destroy, :update]

  def create
    service = Service.new(service_params)
    if service.save
      render json: {message: 'Service created', data: service.as_json}, status: :created
    else
      render json: { error: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    Service.find(params[:id]).destroy!

    render json: {message: 'Service destroyed'}, status: :ok
  end

  def update
    service = Service.find(params[:id])

    service.update(service_params)

    render json: {message: 'Service edited', data: service.as_json}, status: :ok
  end

  def index
    services = Service.all

    render json: services.as_json, status: :ok
  end

  def show
    service = Service.find(params[:id])

    render json: service.as_json, status: :ok
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :price)
  end
end
