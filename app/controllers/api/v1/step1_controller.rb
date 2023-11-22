class Api::V1::Step1Controller < ApplicationController
  require 'cgi'

  def property_details
    {
     user: params[:user],
     user_account_details_id: params[:user_account_details_id],
     location: params[:location],
     location_longitude: params[:location_longitude],
     location_latitude: params[:location_latitude],
     islocation: params[:islocation],
     property_description: params[:property_description],
     property_type: params[:property_type],
     key_features: params[:key_features],
     UPD_FLOOR_SIZE: params[:UPD_FLOOR_SIZE],
     UPD_LAND_AREA: params[:UPD_LAND_AREA],
     additional_features: params[:additional_features],
     additional_key_features: params[:additional_key_features],
     autolist: params[:autolist],
     p_state: params[:p_state],
     p_country: params[:p_country],
     p_city: params[:p_city]
     
    }
  end

  def update_details
    {
      user: params[:user],
      user_account_details_id: params[:user_account_details_id],
      location: params[:location],
      location_longitude: params[:location_longitude],
      location_latitude: params[:location_latitude],
      islocation: params[:islocation],
      property_description: params[:property_description],
      property_type: params[:property_type],
      key_features: params[:key_features],
      UPD_FLOOR_SIZE: params[:UPD_FLOOR_SIZE],
      UPD_LAND_AREA: params[:UPD_LAND_AREA],
      additional_features: params[:additional_features],
      additional_key_features: params[:additional_key_features],
      autolist: params[:autolist],
      p_state: params[:p_state],
      p_country: params[:p_country],
      p_city: params[:p_city],
      autolist: params[:autolist],
      property_id: params[:property_id]
      
     }
  end
  
  def index
    step1_service = UspKodieSaveAddPropertyDetails.new(property_details)
    result= step1_service.create_post_with_tags

    Rails.logger.error(result) 
    render json: { property_id: result, message: "Property Add Successfully" ,status: true }
  end

  def get_key_features
    Rails.logger.error("Step1")
    get_fetaures = UspKodieGetAllAdditionalFeatures.new
    feature_result= get_fetaures.usp_get_additional_feature
    Rails.logger.error("feature_result")
    Rails.logger.error(feature_result)
    render json: { PAF_KEY: feature_result, status: true }
  end

  # def add_property_images
  #   Rails.logger.error("Step 1")
  #   user = params[:user]
    
  #   params[:images][:image].each do  |image_param| 
  #     content_type = image_param.content_type
  #     filename = image_param.original_filename
  #     temp_file_path = image_param.tempfile.path

  #     Rails.logger.error("Processing image: #{filename}")
  #     Rails.logger.error("Temp file path: #{temp_file_path}")

      
  #     @original = filename
  #     save_profile_photo(temp_file_path)

  #     result = UspKodieAddPropertyImages.new(user, content_type, filename, temp_file_path)
  #     result_data = result.save_property_images

  #     Rails.logger.error("Result for image #{filename}: #{result_data}")
  #   end
  #   render json: { message: "Data Successfully Stored for images", status: true }
    
   
  # end
 
  def add_property_images
    Rails.logger.error("Step 1")
    user = params[:user]
   
    images = Array(params[:images])
    video = Array(params[:video])
    for image_param in images
      content_type = image_param.content_type
      filename = image_param.original_filename
      temp_file_path = image_param.tempfile.path
   
      Rails.logger.error("Processing image: #{filename}")
      Rails.logger.error("Temp file path: #{temp_file_path}")
   
      @original = filename
      # @original = CGI.escape(filename)
      save_profile_photo(image_param.tempfile.path)
      
      process_saved_file
   
      result = UspKodieAddPropertyImages.new(user, content_type, filename, temp_file_path)
      result_data = result.save_property_images
      file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original}"
     
    end
    Rails.logger.error(" Video Step 1")
    for image_param in video
      content_type = image_param.content_type
      filename = image_param.original_filename
      temp_file_path = image_param.tempfile.path
   
      Rails.logger.error("Processing image: #{filename}")
      Rails.logger.error("Temp file path: #{temp_file_path}")
   
      @original = filename
      save_profile_photo(image_param.tempfile.path)
 
      process_saved_file
   
      result = UspKodieAddPropertyVideo.new(user, content_type, filename, temp_file_path)
      result_data = result.save_property_video

      file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original}"
     
    end

    render json: { message: "Images And Video Save Successfully", image_photo_path: file_url, profile_photo_name: @original, status: true }
  end

  
  
   
  # def add_property_video
  #   Rails.logger.error(" Video Step 1")
  #   user = params[:user]
    
   
   
  #   for image_param in video
  #     content_type = image_param.content_type
  #     filename = image_param.original_filename
  #     temp_file_path = image_param.tempfile.path
   
  #     Rails.logger.error("Processing image: #{filename}")
  #     Rails.logger.error("Temp file path: #{temp_file_path}")
   
  #     @original = filename
  #     save_profile_photo(image_param.tempfile.path)
 
  #     process_saved_file
   
  #     result = UspKodieAddPropertyVideo.new(user, content_type, filename, temp_file_path)
  #     result_data = result.save_property_video

  #     file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original}"
     
  #   end
   
  #     render json: { message: "Data Successfully Stored for Video", video_path: file_url, video_name: @original, status: true }
  # end
  
  def get_property_details
    Rails.logger.error(" Video Step 1")
    user = params[:user]
    Rails.logger.error(user)
  
     result = UspKodieGetAllPropertyDetailsReview.new(user)
     result_data = result.get_all_details(request)
     Rails.logger.error("result_data")
     Rails.logger.error(result_data)
  

    render json: { property_details: result_data , status: true }

  end

  def update_property_detail
    Rails.logger.error(update_details)
    
    step1_service = UspKodieUpdatePropertyDetails.new(update_details)
    result= step1_service.update_property

    Rails.logger.error(result) 
    render json: {  message: "Property Updated Successfully" ,status: true }

  end

  def update_property_images_video
   
   
    Rails.logger.error("Step 1")
    user = params[:user]
   
    images = Array(params[:images])
    Rails.logger.error(images.length)
    video = Array(params[:video])
    Rails.logger.error(video.length)

    if images.length >0 
    update= UspKodieUpdateImagesVideo.new(user)
    result= update.update_property_images
    Rails.logger.error("Images Deleted Successfully")

    else video.length >0
      update= UspKodieUpdateImagesVideo.new(user)
      result1 =update.update_property_video
      Rails.logger.error("Video Deleted Successfully")

    end  

    for image_param in images
      content_type = image_param.content_type
      filename = image_param.original_filename
      temp_file_path = image_param.tempfile.path
   
      Rails.logger.error("Processing image: #{filename}")
      Rails.logger.error("Temp file path: #{temp_file_path}")
   
      @original = filename
      save_profile_photo(image_param.tempfile.path)
 
      process_saved_file
   
      result = UspKodieAddPropertyImages.new(user, content_type, filename, temp_file_path)
      result_data = result.save_property_images
      file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original}"
     
    end
    Rails.logger.error(" Video Step 1")
    for image_param in video
      content_type = image_param.content_type
      filename = image_param.original_filename
      temp_file_path = image_param.tempfile.path
   
      Rails.logger.error("Processing image: #{filename}")
      Rails.logger.error("Temp file path: #{temp_file_path}")
   
      @original = filename
      save_profile_photo(image_param.tempfile.path)
 
      process_saved_file
   
      result = UspKodieAddPropertyVideo.new(user, content_type, filename, temp_file_path)
      result_data = result.save_property_video

      file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original}"
     
    end

    render json: { message: "Images And Video Updated Successfully", image_photo_path: file_url, profile_photo_name: @original, status: true }
  end  

  private
  
  def save_profile_photo(file)
    filename = File.basename(file)
    local_path = Rails.root.join('public', 'images', @original)
    @full_path = local_path
    FileUtils.cp(file, local_path)
  end
  
  def process_saved_file
   
    saved_file_path = Rails.root.join('public', 'images', @original)
    @saved_file = saved_file_path
    Rails.logger.error("saved_file_path")
    Rails.logger.error(saved_file_path)
    File.open(saved_file_path, 'r') do |file|
      file_content = file.read
      Rails.logger.error("File content:")
      Rails.logger.error(file_content)
    end
  end
    


  
end
