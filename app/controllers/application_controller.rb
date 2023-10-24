class ApplicationController < ActionController::API
    # before_action :authenticate
  
    # private
  
    # def authenticate
    #   token = request.headers['Authorization']&.split(' ')&.last
  
    #   begin
    #     payload, _header = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
    #     session_service = SessionService.new(payload['user_id'])
    #     @current_user = session_service.current_user(payload['user_id'])
        
    #   rescue JWT::DecodeError
    #     render json: { error: 'Invalid token', status: false }, status: :unauthorized
    #   rescue ActiveRecord::RecordNotFound
    #     render json: { error: 'User not found', status: false }, status: :unauthorized
    #   end
    # end
  end
  