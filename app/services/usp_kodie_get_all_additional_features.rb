class UspKodieGetAllAdditionalFeatures
  def usp_get_additional_feature()
    connection = ActiveRecord::Base.connection.raw_connection
    sql = "CALL USP_KODIE_GET_ALL_ADDITIONAL_FEATURES_DETAILS();"
    statement = connection.prepare(sql)
    output = statement.execute
    Rails.logger.error(output)

    results = []
    output.each do |row|
      results << row
    end

    process_data(results)
  ensure
    statement.close if statement
  end

  private

  def process_data(results)
    processed_data = results.map do |row|
      {
        PAF_KEY: row[0],
        PAF_ADDITIONAL_FEATURES_NAME: row[1]
      }
    end
    processed_data
  end
end
