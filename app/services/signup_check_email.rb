class SignupCheckEmail
    

    def initialize(email,otp)
        @email = email ,
        @otp =otp
    end
    def sp_sign_up_otp_check(email,otp)
        connection = ActiveRecord::Base.connection.raw_connection
        @out_message="0";
        @out_generated_on="0";
      
        sql = "CALL USP_KODIE_CHECK_SIGNUP_VERIFICATION_CODE(?, ?, @out_message, @out_generated_on);"
    
        statement = connection.prepare(sql)
        statement.execute(email,otp)
        statement.close
       
      
        queryslect ="SELECT @out_message AS message,@out_generated_on AS generated_on;"
        output_params = connection.query(queryslect).first
        
        message = output_params[0],
        generated_on = output_params[1]
        
        output_data=[message[0],generated_on]
    end    

end    
