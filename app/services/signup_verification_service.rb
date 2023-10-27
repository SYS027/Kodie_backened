class SignupVerificationService

def initialize(email)
    @email =email
end

def sp_generate_verification_code(email)
    connection = ActiveRecord::Base.connection.raw_connection
    @out_otp= "000000"
    sql ="CALL USP_KODIE_GENERATE_OTP(?,@out_otp);"

    statement = connection.prepare(sql)
    statement.execute(email)
    query_select = "SELECT @out_otp AS otp;"
    statement.close

    output_params = connection.query(query_select).first
    otp = output_params[0]
    NotificationMailer.with(email: email).alert_admin(otp).deliver
    Rails.logger.error(otp)
end
   
end
