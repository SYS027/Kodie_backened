class Api::V1::ResetPasswordController < ApplicationController

    def step_1_reset_password
        email = params[:email]
        session_service = ForgotPassword.new(email)
        output = session_service.sp_reset_1(email)
        # render json: { otp: result [0] , result: result ,status: true  }
        render json: { email: email , result_0: output[0], result1:output[1],result: output,message: "Rails"}
    end

    def step_2_reset_password
        email = params[:email]
        otp = params[:otp]
        session_service = ForgotPasswordStepTwo.new(email,otp)
        result = session_service.sp_reset_2(email,otp)
        render json: {message: result[0]  ,generated_on: result[1] , status: true }
    end


end
