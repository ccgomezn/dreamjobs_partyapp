# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Knock::Authenticable
   skip_before_action :verify_authenticity_token
  private

  def check_admin
    user = current_user
    if user.user_type == 0
      return render json: {message: 'Not admin user'}, status: 403
    end
  end
end
