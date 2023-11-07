class UspKodieAddPropertyVideo
    def initialize(user, video_type, video_name, video_path)
        @user = user
        @video_type = video_type
        @video_name = video_name
        @video_path = video_path
      end
    
      def save_property_video
        Rails.logger.error("Processing images for user #{@user}")
        Rails.logger.error("Processing images for user #{@video_type}")
        Rails.logger.error("Processing images for user #{@video_name}")
        Rails.logger.error("Processing images for user #{@video_path}")
        connection = ActiveRecord::Base.connection.raw_connection
        result = connection.query("CALL USP_KODIE_SAVE_PROPERTY_VIDEO('#{@user}', '#{@video_type}', '#{@video_name}', '#{@video_path}')")
    
        connection.close
        Rails.logger.error("step4")
        Rails.logger.error(result)
        result
      end
   
end
