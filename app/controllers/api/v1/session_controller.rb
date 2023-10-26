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
      Rails.logger.error('step1')
       token = JwtService.generate_token(payload)
      Rails.logger.error(user_id)
      #  Rails.logger.error(user_id[0])
       if user_id[0] == "nil"
        render json: { user_id: nil, message: result[1], status: false }
       else
        setService= VerificationService.new(user_id,params[:email],token)
        setData=setService.sp_login_details
       response.headers['Authorization'] = "Bearer #{token}"
      render json: { user_id:user_id, token: token, message: result[1],email: params[:email], status: true }
       end 
       
    else
      render json: { user_id: nil, message: result[1], status: false }
    end
  end
  

  def reset_password
    email = params[:email]
    password = params[:password]
    session_service = ForgotPasswordStep3.new(email, password)
    result = session_service.sp_reset_password(email, password)
    render json: {message: result ,status: true}
  end
end

