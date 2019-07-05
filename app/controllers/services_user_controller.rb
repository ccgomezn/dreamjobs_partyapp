class ServicesUserController < ApplicationController

  def create
    services_user = ServicesUser.new(service_user_params)

    if services_user.save
      render json: {message: 'Service booked'}, status: :created
    else
      render json: { error: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def rate
    service_user = ServicesUser.find_by service_user_rate_params_find

    return render json: {message: 'Service already rated'} unless service_user.rate.nil?

    service_user.update(service_user_rate_params)
    render json: {message: 'Service rated'}, status: :ok
  end

  def update
    service_user = ServicesUser.find(params[:id])
    service_user.update(service_user_employee)
    render json: {message: 'Employee asociated'}, status: :ok
  end

  private

  def service_user_params
    params.require(:user_service).permit(:user_id, :adress, :city, :country, :service_id)
  end

  def service_user_rate_params_find
    params.require(:user_service).permit(:user_id, :service_id)
  end

  def service_user_rate_params
    params.require(:rate).permit(:rate)
  end

  def service_user_employee
    params.require(:employee).permit(:employee_id)
  end
end
