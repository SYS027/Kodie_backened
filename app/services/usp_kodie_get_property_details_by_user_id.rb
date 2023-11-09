class UspKodieGetPropertyDetailsByUserId
  def initialize(user)
    @user = user
  end

  def get_property_details(request)
    Rails.logger.error("step1prop")
    Rails.logger.error(@user)
    connection = ActiveRecord::Base.connection.raw_connection
    result = connection.query("CALL USP_KODIE_GET_ALL_PROPERTY_DETAILS_BY_USER_ID('#{@user}')")

    connection.close
    Rails.logger.error("step2prop")
    Rails.logger.error(result.to_a)
    results = []
    result.each do |row|
      results << row
    end

    # Pass request as a parameter to process_data
    processed_data = process_data(results, request)

    # Return processed_data
    processed_data
  end

  private

  def process_data(results, request)
    processed_data = results.map do |row|
      {
        image_path: "#{request.protocol}#{request.host_with_port}/images/#{row[0]}",
        location: row[2],
        property_type: row[1],
      }
    end
    processed_data
  end
end
