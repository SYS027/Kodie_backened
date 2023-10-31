class Api::V1::ResetPasswordController < ApplicationController

    def step_1_reset_password
        email = params[:email]
        otp = rand(100_000..999_999)
        session_service = UspKodieResetPasswordStep1.new(email,otp)
        result = session_service.sp_reset_1(email)
        Rails.logger.error("result")
        Rails.logger.error(result)
        if result == -1

            render json: { message: "User not Registered" , status: false }
        else    
        render json: { message: "OTP Sended Successfully" , status: true }
        end
    end

    
    def reset_password
        email = params[:email]
        password = params[:password]
        session_service = UspKodieResetPasswordStep3.new(email, password)
        result = session_service.sp_reset_password(email, password)
        Rails.logger.error(result)
        if result == 1
            render json: {message: "Password Successfully Updated" ,status: true}
        else
            render json: {message: "Password Not Updated" ,status: false}
        end    
    end


    def generate_otp
        rand(100_000..999_999)
      end

end
