class ForgotPassword
   
    def initialize(email)
    @email = email 
    end

    def sp_reset_1(email)
        connection = ActiveRecord::Base.connection.raw_connection
        @out_otp=0;
        sql = "CALL RESET_PASSWORD_(?, @out_otp);"
    
        statement = connection.prepare(sql)
        statement.execute(email)
        statement.close
       
      
        queryslect ="SELECT @out_otp AS otp;"
        output_params = connection.query(queryslect).first
        
          otp = output_params[0],
         
        
        output_data=[otp]
       
    end


end    
