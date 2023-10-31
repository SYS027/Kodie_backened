# app/controllers/sessions_controller.rb
class Api::V1::SessionController < ApplicationController

  def login
      email = params[:email]
      password = params[:password]
  
      login_function_call = UspKodieLoginService.new(email, password)
      result= login_function_call.USP_LOGIN_DETAILS
  
      if result == 1
        payload = {
          email: email,
          exp: 1.hour.from_now.to_i
        }
        token=JwtService.generate_token(payload)
        Rails.logger.error(token)
        response.headers['Authorization'] = "Bearer #{token}"
        result=UspKodieSetLoginDetailsService.new(email,token,"1","1")
        details= result.sp_login_details
        Rails.logger.error(details)
        render json: { message: 'Login successful', token: token ,status: true }
      else
        render json: { message: 'Invalid login details', status: false }, status: :unauthorized
      end
  end
  

  
end

