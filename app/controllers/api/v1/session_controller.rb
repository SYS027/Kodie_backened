# app/controllers/sessions_controller.rb
class Api::V1::SessionController < ApplicationController

  def login
      email = params[:email]
      password = params[:password]
      session_service = SessionService.new(email, password)
      result = session_service.sp_session(email, password)
  
      if result[0].present?
        user_id = result[0]
        payload = {
          user_id: user_id,
          message: result[1]
        }
        expiration_time = 1.hour.from_now.to_i
        payload[:exp] = expiration_time     
        if result[1] != "Invalid credentials"
          token = JwtService.generate_token(payload)
          render json: { user_id: user_id, message: result[1], token: token }
        else
          render json: { user_id: nil, message: result[1] }
        end
      else
        render json: { user_id: nil, message: result[1] }
      end
  end

  def logout
  end

  
  def reset_password
    user_id = params[:user_id]
    password = params[:password]
    session_service = SessionService.new(user_id, password)
    result = session_service.sp_reset_password(user_id, password)
    render json: {message: result}
  end
end

