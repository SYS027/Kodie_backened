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
  
    result = signup_service.signup
    Rails.logger.error("step1")
    
  
    Rails.logger.error("pankaj2")
    if result == "Email id already exists"
      Rails.logger.error("pankaj4")
      render json: { message: 'User already exists', otp: "null", status: false }
    else
      Rails.logger.error("pankaj5")
      otp_service = SignupVerificationService.new(email)
      Rails.logger.error("step4")
      otp = otp_service.sp_generate_verification_code(email)
      Rails.logger.error("step2")
      Rails.logger.error(otp)
      render json: { message: 'User Successfully Signup', otp: otp, status: true }
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
