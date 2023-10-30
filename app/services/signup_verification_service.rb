class SignupVerificationService

def initialize(email)
    @email =email
end

	def sp_generate_verification_code(email)
	connection = ActiveRecord::Base.connection.raw_connection
	@out_otp="000000";

	sql = "CALL USP_KODIE_GENERATE_OTP(?, @out_otp);"


	statement = connection.prepare(sql)
	statement.execute(email)
	statement.close
 

	queryslect ="SELECT @out_otp AS otp;"
	output_params = connection.query(queryslect).first
	Rails.logger.error("SignupStep1")
	Rails.logger.error(output_params)
	Rails.logger.error("SignupStep2")
    
  end 

	
	
   
end


