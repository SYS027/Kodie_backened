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
      signup_service.signup
      render json: { message: 'User signed up successfully' ,status: true}
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: 'User with this email already exists' , status: false}, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: 'User with this email already exists' , status: false }, status: :internal_server_error
    end
  end
end
