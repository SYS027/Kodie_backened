class UspKodieVerifyEmail
    

    def initialize(email,otp)
        @email = email ,
        @otp =otp
    end
    def sp_sign_up_otp_check(email,otp)
        Rails.logger.error('Step1')
				Rails.logger.error(@email[0])
        Rails.logger.error(@otp)
      
        result = ActiveRecord::Base.connection.execute("SELECT UFUN_KODIE_VERIFIED_SIGNUP_DETAILS('#{@email[0]}','#{@otp}') AS result")
        
        Rails.logger.error('Step2')
        Rails.logger.error(result.to_a) 
        value = result.to_a.flatten.first
        Rails.logger.error(value)
        value
    end    

end    
