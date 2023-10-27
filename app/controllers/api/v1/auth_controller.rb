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
      Rails.logger.error("step1")
      otp_service=SignupVerificationService.new(email)
      Rails.logger.error("step4")
      otp=otp_service.sp_generate_verification_code(email)
      Rails.logger.error("step2") 
      render json: { message: 'User signed up successfully' ,otp: otp,status: true}
    rescue ActiveRecord::RecordNotUnique => e
      render json: { error: 'User with this email already exists 1' , status: false}, status: :unprocessable_entity
    rescue StandardError => e
      render json: { error: 'User with this email already exists 2' , status: false }, status: :internal_server_error
    end
  end

  def Signup_Check
    email = params[:email]
    otp = params[:otp]
    session_service = SignupCheckEmail.new(email, otp)
    result = session_service.sp_sign_up_otp_check(email, otp)
    Rails.logger.error(result[0])
    Rails.logger.error(result[1])
    
    render json: {
        message: result[0],
        generated_on: result[1],
        status: (result[0] == "not verified" ? false : true)
      } 
   
  end 
end
