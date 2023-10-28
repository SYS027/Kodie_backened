class UspKodieSignupService
  def initialize(email, password, otp)
    @email = email
    @password = password
    @otp = otp 
  end

  def USP_KODIE_SIGNUP_DETAILS
    Rails.logger.error('Step1')
    Rails.logger.error(@otp)
  
    result = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_SAVE_SIGNUP_DETAILS('#{@email}', '#{@password}', '#{@otp}') AS result")
    NotificationMailer.with(email: @email).alert_admin(@otp).deliver
    Rails.logger.error('Step2')
    Rails.logger.error(result.to_a) 
    value = result.to_a.flatten.first
    Rails.logger.error(value)
   
    value
  end

  
end

