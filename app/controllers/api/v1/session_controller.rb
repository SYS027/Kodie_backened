# app/controllers/sessions_controller.rb
class Api::V1::SessionController < ApplicationController

  def login
      email = params[:email]
      password = params[:password]
      Rails.logger.error(password)
      updated_password=Base64.encode64(password)
      Rails.logger.error(updated_password)
      login_function_call = UspKodieLoginService.new(email, updated_password)
      result= login_function_call.USP_LOGIN_DETAILS
      Rails.logger.error("result")
      Rails.logger.error(result)
      if result == 0

        render json: { message: 'Invalid login details', status: false }, status: :unauthorized
       
      else
        payload = {
          email: email,
          exp: 1.hour.from_now.to_i
        }
        token=JwtService.generate_token(payload)
        Rails.logger.error(token)
        response.headers['Authorization'] = "Bearer #{token}"
        result=UspKodieSetLoginDetailsService.new(result,email,token,"1","1")
        details= result.sp_login_details
        Rails.logger.error(details)
        render json: { message: 'Login successful' ,Login_details: result , details: details ,status: true }
      end
  end
  

  
end

