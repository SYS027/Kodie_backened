class Api::V1::Step1Controller < ApplicationController
   

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
     additional_features: params[:additional_features],
     additional_key_features: params[:additional_key_features],
     autolist: params[:autolist]
    }
  end
  
  def index
    step1_service = UspKodieSaveAddPropertyDetails.new(property_details)
    result= step1_service.create_post_with_tags

    Rails.logger.error(result) 
    render json: { message: result, status: true }
  end

  def get_key_features
    Rails.logger.error("Step1")
    get_fetaures = UspKodieGetAllAdditionalFeatures.new
    feature_result= get_fetaures.usp_get_additional_feature
    Rails.logger.error("feature_result")
    Rails.logger.error(feature_result)
    render json: { PAF_KEY: feature_result, status: true }
  end

  def add_property_images
    Rails.logger.error("Step 1")
    user = params[:user]
    images_params = Array(params[:images])
  
    if images_params.present?
      images_params.each do |image_param|
        content_type = image_param.content_type
        filename = image_param.original_filename
        temp_file_path = image_param.tempfile.path
  
        Rails.logger.error("Processing image: #{filename}")
        Rails.logger.error("Temp file path: #{temp_file_path}")
  
        
        @original = filename
        save_profile_photo(temp_file_path)
  
        result = UspKodieAddPropertyImages.new(user, content_type, filename, temp_file_path)
        result_data = result.save_property_images
  
        Rails.logger.error("Result for image #{filename}: #{result_data}")
      end
  
      render json: { message: "Data Successfully Stored for #{images_params.length} images", status: true }
    else
      render json: { message: "No images provided", status: false }
    end
  end

  def add_property_video
    Rails.logger.error(" Video Step 1")
    user = params[:user]
    images_params = Array(params[:video])
  
    if images_params.present?
      images_params.each do |image_param|
        content_type = image_param.content_type
        filename = image_param.original_filename
        temp_file_path = image_param.tempfile.path
  
        Rails.logger.error("Processing image: #{filename}")
        Rails.logger.error("Temp file path: #{temp_file_path}")
  
        
        @original = filename
        save_profile_photo(temp_file_path)
  
        result = UspKodieAddPropertyVideo.new(user, content_type, filename, temp_file_path)
        result_data = result.save_property_video
  
        Rails.logger.error("Result for image #{filename}: #{result_data}")
      end
  
      render json: { message: "Data Successfully Stored for #{images_params.length} video", status: true }
    else
      render json: { message: "No video provided", status: false }
    end
  end
  
  def get_property_details
    Rails.logger.error(" Video Step 1")
    user = params[:user]
    Rails.logger.error(user)
  
     result = UspKodieGetAllPropertyDetailsReview.new(user)
     result_data = result.get_all_details
   
     Rails.logger.error(result_data)
  

    render json: { message: "get Successfully Stored for #{result_data} video", status: true }

  end


  private
  
  def save_profile_photo(file)
    filename = File.basename(file)
    Rails.logger.error(@original)
    
    local_path = Rails.root.join('public', 'images', @original)
  
    FileUtils.cp(file, local_path)
  end
    


  
end
