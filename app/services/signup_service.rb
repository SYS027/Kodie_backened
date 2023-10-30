# app/services/user_signup_service.rb
class SignupService
  def initialize(email, password, is_term_condition, is_privacy_policy)
    @email = email
    @password = password
    @is_term_condition = is_term_condition
    @is_privacy_policy = is_privacy_policy
  end

  def signup(email, password, is_term_condition, is_privacy_policy)
    
    connection = ActiveRecord::Base.connection.raw_connection
    @out_message="0";
    sql = "CALL USP_KODIE_INSERT_SIGNUP(?, ?, ?, ?,@out_message);"
    statement = connection.prepare(sql)
    statement.execute(email, password, is_term_condition, is_privacy_policy)
    statement.close
   
    queryslect ="SELECT @out_message AS message;"
    output_params = connection.query(queryslect).first
    Rails.logger.error(output_params[0])
    value=output_params[0]
    Rails.logger.error("signup success")
    Rails.logger.error(value)
    value


  end

end
