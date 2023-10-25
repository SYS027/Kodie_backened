class Api::V1::AuthController < ApplicationController
  def signup
    email = params[:email]
    password = params[:password]
    is_term_condition = params[:is_term_condition]
    is_privacy_policy = params[:is_privacy_policy]

    signup_service = SignupService.new(
      email,
      password,
      is_term_condition,
      is_privacy_policy
    )

    begin
      # Try to sign up the user using the service
      signup_service.signup
      # NotificationMailer.alert_admin.deliver
      # User signed up successfully
      render json: { message: 'User signed up successfully' ,status: true}
    rescue ActiveRecord::RecordNotUnique => e
      # Handle the case where the email is not unique
      render json: { error: 'User with this email already exists' , status: false}, status: :unprocessable_entity
    rescue StandardError => e
      # Handle other errors if needed
      render json: { error: 'User with this email already exists' , status: false }, status: :internal_server_error
    end
  end

  
end
