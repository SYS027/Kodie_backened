class Api::V1::VerificationController < ApplicationController
    def step_1_reset_password
        email = params[:email]
        session_service = VerificationService.new(email)
        result = session_service.sp_reset_1(email)
        render json: { otp: result[0] , message: 'ok' , status: true }
    end
end
