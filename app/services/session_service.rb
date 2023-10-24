# app/services/session_service.rb
class SessionService
  def sp_session(email, password)
    connection = ActiveRecord::Base.connection.raw_connection
    @out_user_id=0;
    @out_message="0";
    sql = "CALL USP_KODIE_MANAGE_SESSION(?, ?, @out_user_id, @out_message);"

    statement = connection.prepare(sql)
    statement.execute(email, password)
    statement.close
   
  
    queryslect ="SELECT @out_user_id AS user_id, @out_message AS message;"
    output_params = connection.query(queryslect).first
    
      user_id = output_params[0],
      message = output_params[1]
    
    output_data=[user_id,message]
   
  end
  
  


  def initialize(user_id, password)
    @user_id = user_id
    @password = password
  end
  
  def sp_reset_password(user_id,password)
    result = ActiveRecord::Base.connection.execute("
      CALL USP_KODIE_MANAGE_RESET_PASSWORD(
        '#{@user_id}',
        '#{@password}'
      )
    ")
  end
end
