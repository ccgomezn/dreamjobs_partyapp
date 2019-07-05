class EmployeeController < ApplicationController

  before_action :authenticate_user
  before_action :check_admin

  def create
    employee = Employee.new(employee_params)
    if employee.save
      render json: {message: 'Employee created', data: employee.as_json}, status: :created
    else
      render json: { error: employee.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    Employee.find(params[:id]).destroy!

    render json: {message: 'Employee destroyed'}, status: :ok
  end

  def update
    employee = Employee.find(params[:id])

    employee.update(employee_params)

    render json: {message: 'Employee edited', data: employee.as_json}, status: :ok
  end

  def index
    employees = Employee.all

    render json: employees.as_json, status: :ok
  end

  def show
    employee = Employee.find(params[:id])

    render json: employee.as_json, status: :ok
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :phone_number, :national_id)
  end
end
