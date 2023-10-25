# app/services/user_signup_service.rb
class SignupService
  def initialize(email, password, is_term_condition, is_privacy_policy)
    @email = email
    @password = password
    @is_term_condition = is_term_condition
    @is_privacy_policy = is_privacy_policy
  end

  def signup
    
    # Execute the stored procedure using ActiveRecord
    result = ActiveRecord::Base.connection.execute("
      CALL USP_KODIE_INSERT_SIGNUP(
        '#{@email}',
        '#{@password}',
        #{@is_term_condition ? 1 : 0},
        #{@is_privacy_policy ? 1 : 0}
      )
    ")
   
  end

end
