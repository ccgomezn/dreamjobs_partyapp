class ServicesUserController < ApplicationController
  before_action :authenticate_user
  before_action :check_admin, only: [:update]

  def create
    services_user = ServicesUser.new(service_user_params)

    if services_user.save
      render json: {message: 'Service booked', data: services_user.as_json}, status: :created
    else
      render json: { error: services_user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def rate
    service_user = ServicesUser.find params[:id]

    return render json: {message: 'Service already rated', data: service_user.as_json}, status: 422 unless service_user.rating.nil?

    service_user.update(service_user_rate_params)
    render json: {message: 'Service rated'}, status: :ok
  end

  def update
    services_user = ServicesUser.find params[:id]
    services_user.update(service_user_employee_params)
    user = User.find(services_user.user_id)
    service = Service.find(services_user.service_id)
    employee = Employee.find(service_user_employee_params[:employee_id])
    ServicesUserMailer.service_association(user, service, employee).deliver
    message = 'Your service has been associated to ' + employee.name
    TwilioTextMessenger.new(message, user.phone_number).call
    render json: {message: 'Employee asociated', data: services_user.as_json}, status: :ok
  end

  private

  def service_user_params
    params.require(:user_service).permit(:user_id, :address, :city, :country, :service_id)
  end

  def service_user_rate_params_find
    params.require(:user_service).permit(:user_id, :service_id)
  end

  def service_user_rate_params
    params.require(:rate).permit(:rating)
  end

  def service_user_employee_params
    params.require(:employee).permit(:employee_id)
  end
end
