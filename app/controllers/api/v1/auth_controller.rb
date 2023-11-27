class Api::V1::AuthController < ApplicationController
 
  

  def signup
   
    Rails.logger.error('Step1')
      email = params[:email]
      password = params[:password]
      is_term_condition = params[:is_term_condition]
      is_privacy_policy = params[:is_privacy_policy]
      otp = rand(100_000..999_999)
      Rails.logger.error(password)
      updated_password=Base64.encode64(password)
      Rails.logger.error(updated_password)
     
      Rails.logger.error('Step1')
      signup_function_call = UspKodieSignupService.new(email, updated_password,is_term_condition,is_privacy_policy, otp)
      Rails.logger.error('Step1')
     
       result= signup_function_call.USP_KODIE_SIGNUP_DETAILS
       Rails.logger.error("result")
       Rails.logger.error(result)
       Rails.logger.error(otp)
       if result == -1
        NotificationMailer.with(email: email).alert_admin(otp).deliver
        render json: { message: 'User Already Exists But Not Verified', otp: otp,status: true }
      elsif result == -2
        render json: { message: 'User Already Exists And Verified', status: true }
      else
        NotificationMailer.with(email: email).alert_admin(otp).deliver
        render json: { message: 'User Signup Successful', User_Key: result, otp: otp,status: true }
      end
 
  end
 
  def Signup_Check
    email = params[:email]
    otp = params[:otp]
    session_service = UspKodieVerifyEmail.new(email, otp)
    result = session_service.sp_sign_up_otp_check(email, otp)
    Rails.logger.error("result")
    Rails.logger.error(result)
   
    if result == 1
      render json: { message: 'OTP verified', status: true }
    else
      render json: { message: 'OTP not verified', status: false }
    end
  end
  private
 
  def generate_otp
    rand(100_000..999_999)
  end
 
end