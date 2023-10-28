class UspKodieResetPasswordStep1
  def initialize(email,otp)
    @email = email
    @otp = otp
  end

  def sp_reset_1(email)
    Rails.logger.error('Step1')
    Rails.logger.error(@otp)
  
    result = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_FORGET_UPDATE_OTP_DETAILS('#{@email}', '#{@otp}') AS result")
    NotificationMailer.with(email: @email).alert_admin(@otp).deliver
    Rails.logger.error('Step2')
    Rails.logger.error(result.to_a) 
    value = result.to_a.flatten.first
    Rails.logger.error(value)
   
    value
  end
end










