class CurrentService
 
    def initialize(user_id)
        @user_id = user_id
      end
    
     def current_user(user_id)
      connection = ActiveRecord::Base.connection.raw_connection
      @out_email="0";
      sql = "CALL USP_KODIE_FETCH_USER_CURRENTUSER(?, @out_email);"
    
      statement = connection.prepare(sql)
      statement.execute(user_id)
      statement.close
     
    
      queryslect ="SELECT @out_email AS user_id"
      output_params = connection.query(queryslect).first
      
        email = output_params[0]
       
      
      output_data=[email]
     end
end    
