class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def sign_in
    user = User.find_by(email: sign_in_params[:email])
    if user && user.valid_password?(sign_in_params[:password])
      user.update_attributes(auth_token: SecureRandom.uuid.gsub(/\-/, ''))
      render json: { auth_token: user.auth_token, message: "You have logged in successfully." }, status: :ok
    else
      render json: { status: 401, message: "Please check email or password" }, status: :not_acceptable
    end
  end

  def sign_up
    user = User.create(sign_up_params.merge!({role_id: 2}))
    if user.save
      user.update_attributes(auth_token: SecureRandom.uuid.gsub(/\-/, ''))
      render json: { message: "User registered successfully." }, status: :ok
    else
      render json: { message: user.errors.full_messages.join(', ') }, status: :not_acceptable
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def sign_in_params
    params.require(:user).permit(:email, :password)
  end  
end