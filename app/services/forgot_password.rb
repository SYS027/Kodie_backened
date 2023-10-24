class ForgotPassword
    def initialize(email)
      @email = email
    end
  
    def sp_reset_1(email)
      begin
        connection = ActiveRecord::Base.connection.raw_connection
        @out_otp = 0
        sql = "CALL RESET_PASSWORD_(?, @out_otp);"
  
        statement = connection.prepare(sql)
        statement.execute(email)
        statement.close
  
        query_select = "SELECT @out_otp AS otp;"
        output_params = connection.query(query_select).first
  
        otp = output_params[0]
        output_data = ["1"]
      rescue ActiveRecord::StatementInvalid => e
        # Handle database statement execution error here
        puts "Database statement error: #{e.message}"
      rescue StandardError => e
        # Handle other exceptions here
        puts "An error occurred: #{e.message}"
      ensure
        # Ensure the database connection is closed
        connection.close if connection
      end
    end
  end