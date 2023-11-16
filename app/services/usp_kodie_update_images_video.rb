class UspKodieUpdateImagesVideo
  
    def initialize(property_id)
      @property_id=property_id
    end 

  
    def update_property_images
        Rails.logger.error("3")
        Rails.logger.error(@property_id)
       
        connection = ActiveRecord::Base.connection.raw_connection
        
        sql = "CALL USP_KODIE_UPDATE_IMAGES(?);"
        Rails.logger.error("4")
        statement = connection.prepare(sql)
        statement.execute(@property_id)
        Rails.logger.error("5")
       
        statement.close
    end    
    def update_property_video
      Rails.logger.error("3")
      Rails.logger.error(@property_id)
     
      connection = ActiveRecord::Base.connection.raw_connection
      
      sql = "CALL USP_KODIE_UPDATE_VIDEO(?);"
      Rails.logger.error("4")
      statement = connection.prepare(sql)
      statement.execute(@property_id)
      Rails.logger.error("5")
     
      statement.close
  end  


end    