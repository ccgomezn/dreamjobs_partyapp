class ServicesUserController < ApplicationController

  def create
    services_user = ServicesUser.new(service_user_params)

    if services_user.save
      render json: {message: 'Service booked'}, status: :created
    else
      render json: { error: services_user.errors.full_messages },
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
    service_user = ServicesUser.where(service_user_rate_params_find)
    service_user.update_all(employee_id: service_user_employee_params[:employee_id])
    user = User.find(service_user.first.user_id)
    service = Service.find(ServicesUser.first.service_id)
    employee = Employee.find(service_user_employee_params[:employee_id])
    ServicesUserMailer.service_association(user, service, employee).deliver
    message = 'Your service has been associated to ' + employee.name
    TwilioTextMessenger.new(message, user.phone_number).call
    render json: {message: 'Employee asociated'}, status: :ok
  end

  private

  def service_user_params
    params.require(:user_service).permit(:user_id, :address, :city, :country, :service_id)
  end

  def service_user_rate_params_find
    params.require(:user_service).permit(:user_id, :service_id)
  end

  def service_user_rate_params
    params.require(:rate).permit(:rate)
  end

  def service_user_employee_params
    params.require(:employee).permit(:employee_id)
  end
end
