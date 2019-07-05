class ServicesUserMailer < ApplicationMailer
  default from: "gfcristhian98@gmail.com"

  def service_association(user, service, employee)
    @user = user
    @service = service
    @employee = employee
    p "uesssssssssss"
    p user.email
    mail(to: "#{user.email}", :subject => "Employee asociated to your service")
  end
end
