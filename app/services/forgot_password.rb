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

      # Move to the next result set
      connection.next_result if connection.respond_to?(:next_result)

      query_select = "SELECT @out_otp AS otp;"
      result = connection.query(query_select).first

      otp = result[0]
      output_data = [otp]
    rescue ActiveRecord::StatementInvalid => e
      # Handle database statement execution error here
      output_data = ["#{e.message}"]
    rescue StandardError => e
      # Handle other exceptions here
      output_data = ["#{e.message}"]
    ensure
      # Ensure the database connection is closed
      connection.close if connection
    end
  end
end
