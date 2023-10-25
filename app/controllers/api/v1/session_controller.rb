# app/controllers/sessions_controller.rb
class Api::V1::SessionController < ApplicationController

  # def current_user
  #   user_id = params[:user_id]
  #   session_service = SessionService.new(user_id)
  #   result = session_service.current_user
  #   render json: { email: result[0] , status: true }
  # end
 

  def login
    email = params[:email]
    password = params[:password]
    session_service = SessionService.new
    result = session_service.sp_session(email, password)
    
    if result[0].present?
      user_id = result[0]
      session_service = CurrentService.new(user_id)
      user = session_service.current_user(user_id)
      email = result[0]
      payload = {
        user_id: user_id,
        email: email,
        exp: 1.hour.from_now.to_i
      }
  
       token = JwtService.generate_token(payload)
       response.headers['Authorization'] = "Bearer #{token}"
      render json: { user_id: user_id, token: token, message: result[1], status: true }
    else
      render json: { user_id: nil, message: result[1], status: false }
    end
  end
  

  def reset_password
    email = params[:email]
    password = params[:password]
    session_service = ForgotPasswordStep3.new(email, password)
    result = session_service.sp_reset_password(email, password)
    render json: {message: result}
  end
end

