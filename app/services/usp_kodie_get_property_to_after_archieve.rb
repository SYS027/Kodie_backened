class UspKodieGetPropertyToAfterArchieve
    def initialize(user,page_no,p_limit,p_order_col,p_order_wise)
      @user = user
      @page_no= page_no
      @p_limit =p_limit
      @p_order_col =p_order_col
      @p_order_wise = p_order_wise
    end
  
    def get_property_details(request)
      Rails.logger.error("step1prop")
      Rails.logger.error(@user)
      connection = ActiveRecord::Base.connection.raw_connection
      result = connection.query("CALL USP_KODIE_GET_ALL_PROPERTY_DETAILS_BY_USER_ID_TEST_Archieve('#{@user}','#{@page_no}','#{@p_limit}','#{@p_order_col}','#{@p_order_wise}')")
  
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
          property_id: row[0],
          image_path: generate_image_paths(row[1], request, "prefix_"),
          location: row[4],
          property_type: row[3],
          property_type_id: row[2]
        }
      end
      processed_data
    end
    def generate_image_paths(image_names, request, prefix_text)
     
      return [] if image_names.nil?
      
      Rails.logger.error(image_names)
       image_names_array = image_names.split(',').map(&:strip)
       Rails.logger.error(image_names_array)
      base_url = "#{request.protocol}#{request.host_with_port}/images/"
      image_paths_array = image_names_array.map { |image_name| "#{base_url}#{image_name}" }
      Rails.logger.error(image_paths_array)
      image_paths_array
    end
  end
  