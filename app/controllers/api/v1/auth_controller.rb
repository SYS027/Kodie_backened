class Api::V1::AuthController < ApplicationController
 
  def signup
   
    Rails.logger.error('Step1')
      email = params[:email]
      password = params[:password]
      is_term_condition = params[:is_term_condition]
      is_privacy_policy = params[:is_privacy_policy]
      otp = rand(100_000..999_999)
     
     
      Rails.logger.error('Step1')
      signup_function_call = UspKodieSignupService.new(email, password,is_term_condition,is_privacy_policy, otp)
      Rails.logger.error('Step1')
     
       result= signup_function_call.USP_KODIE_SIGNUP_DETAILS
       Rails.logger.error("result")
       Rails.logger.error(result)
       if result === -1
        render json: { message: 'User Already Exists', status: false }
      else
        render json: { message: 'User Signup Successfull', User_Key: result, status: true }
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
      render json: { message: 'OTP Verified', status: true }
    else
      render json: { message: 'OTP Not Verified', status: false }
    end
  end
  private
 
  def generate_otp
    rand(100_000..999_999)
  end
 
end