class UspKodieSignupService
  def initialize(email, password, is_term_condition, is_privacy_policy, otp)
    @email = email
    @password = password
    @is_term_condition = is_term_condition
    @is_privacy_policy = is_privacy_policy
    @otp = otp
  end
 
  def USP_KODIE_SIGNUP_DETAILS
    Rails.logger.error('Step1')
    Rails.logger.error(@otp)
 
    statement = ActiveRecord::Base.connection.raw_connection.prepare(
      "SELECT UFUN_KODIE_SAVE_SIGNUP_DETAILS(?, ?, ?, ?, ?) AS result"
    )
 
    result = statement.execute(
      @email,
      @password,
      @is_term_condition,
      @is_privacy_policy,
      @otp
    )
 
    NotificationMailer.with(email: @email).alert_admin(@otp).deliver
    Rails.logger.error('Step2')
    Rails.logger.error(result.to_a)
    value = result.to_a.flatten.first
    Rails.logger.error(value)
 
    statement.close
 
    value
  end
end