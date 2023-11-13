class UspKodieLoginService
  def initialize(email, password)
    @email = email
    @password = password
  end

  def USP_LOGIN_DETAILS
    Rails.logger.error('Step1')
    result = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_VALIDATE_LOGIN_DETAILS('#{@email}', '#{@password}') AS result")
    Rails.logger.error('Step2')
    Rails.logger.error(result)
    Rails.logger.error('Step2')
    Rails.logger.error(result.to_a) 
    value = result.to_a.flatten.first
    Rails.logger.error(value)
   
    
    value
  end
end
