class UserTokenController < Knock::AuthTokenController
 skip_before_action :verify_authenticity_token

  def create
    user = User.find_by email: auth_params[:email]
    p user.user_type
    if user.user_type == 0 and user.state == false
      return render json: {message: 'User not activated'}, status: 403
    end

    super
  end
end
