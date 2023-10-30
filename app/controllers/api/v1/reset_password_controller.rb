class Api::V1::ResetPasswordController < ApplicationController

    def step_1_reset_password
        email = params[:email]
        session_service = ForgotPassword.new(email)
        result = session_service.sp_reset_1(email)
        Rails.logger.error(result)
       
        if result == "Email not verified"
            render json: { otp: "null", status: false,message: "Email is not Registered" }
          else
            render json: { otp: result, status: true , message: "OTP Sended" }
          end
    end

    def step_2_reset_password
        email = params[:email]
        otp = params[:otp]
        session_service = ForgotPasswordStepTwo.new(email, otp)
        result = session_service.sp_reset_2(email, otp)
        Rails.logger.error(result[0])
        Rails.logger.error(result[1])
        
        render json: {
            message: result[0],
            generated_on: result[1],
            status: (result[0] == "not verified" ? false : true)
          } 
       
    end


end
