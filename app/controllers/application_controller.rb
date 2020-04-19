class ApplicationController < ActionController::Base

  private
  def is_authenticated
    @user = User.find_by(auth_token: request.headers['Authorization'])
    render json: { error: 'User is not authorized.' }, status: 401 unless @user
  end
end
