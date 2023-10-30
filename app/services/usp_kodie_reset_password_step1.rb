class UspKodieResetPasswordStep1
  def initialize(email,otp)
    @email = email
    @otp = otp
  end

  
  def sp_reset_1(email)
    Rails.logger.error('Step1')
    Rails.logger.error(@otp)
     
    result1 = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_CHECK_USER_EXISTENCE('#{@email}') AS result")
    Rails.logger.error(result1.to_a) 
    value1 = result1.to_a.flatten.first
    Rails.logger.error(value1)
    
     
    if value1 == 1

    result = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_FORGET_UPDATE_OTP_DETAILS('#{@email}', '#{@otp}') AS result")
    NotificationMailer.with(email: @email).alert_admin(@otp).deliver
    Rails.logger.error('Step2')
    Rails.logger.error(result.to_a) 
    value = result.to_a.flatten.first
    Rails.logger.error(value)
  
    value
    else
     value=-1
     value
    end   
  end
end










