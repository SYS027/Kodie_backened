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

  # def add_property_images
  #   user = params[:user]
  #   images = params[:images]

  #   Rails.logger.error("step1")
  #   Rails.logger.error("step2")
  #   Rails.logger.error(images)

  #   images_result = []

  #   if images.is_a?(Array)
  #     images.each do |image|
  #       next if image.nil?

  #       content_type = image.content_type
  #       original_filename = image.original_filename
  #       temp_file_path = image.tempfile.path

  #       images_type = content_type
  #       images_name = original_filename
  #       images_path = temp_file_path

  #       Rails.logger.error(user)
  #       Rails.logger.error(images_type)
  #       Rails.logger.error(images_name)
  #       Rails.logger.error(images_path)

  #       add_images = UspKodieAddPropertyImages.new(user, images_type, images_name, images_path)
  #       result = add_images.save_property_images

  #       images_result << result
  #     end
  #   else
  #     # Handle the case when only one image is sent
  #     content_type = images&.content_type
  #     original_filename = images&.original_filename
  #     temp_file_path = images&.tempfile&.path

  #     if content_type && original_filename && temp_file_path
  #       images_type = content_type
  #       images_name = original_filename
  #       images_path = temp_file_path

  #       Rails.logger.error(user)
  #       Rails.logger.error(images_type)
  #       Rails.logger.error(images_name)
  #       Rails.logger.error(images_path)

  #       add_images = UspKodieAddPropertyImages.new(user, images_type, images_name, images_path)
  #       result = add_images.save_property_images

  #       images_result << result
  #     end
  #   end

  #   Rails.logger.error("images_result")
  #   Rails.logger.error(images_result)

  #   render json: { PAF_KEY: images_result, status: true }
  # end


  def your_action
    files = params[:images]
file_index = 0
  Rails.logger.error(files.length)
while file_index < files.length
  file = files[file_index]

  # Your logic for each uploaded file here...
  # For example, you can access file.original_filename, file.tempfile, etc.
  Rails.logger.error("Processing file: #{file.original_filename}")

  file_index += 1
end
  end


  def add_property_images
    your_action()
    Rails.logger.error("step1")
    user = params[:user]
    # images_params = params[:images]
    # images_params = Array(images_params)

    # image_length = images_params.length
    # Rails.logger.error(image_length)
  
    profile_photo_path = Array(images_params)
    if profile_photo_path.present?
      save_profile_photo(profile_photo_path.tempfile)
      account_details['profile_photo'] = profile_photo_path.original_filename
    end
  
    Rails.logger.error("Processing images for user #{user}")
    
  
    if images_params.is_a?(Array)
      images_params = images_params.map { |image| { images_type: image[:images_type], images_name: image[:images_name], images_path: image[:images_path] } }
  
      add_images = UspKodieAddPropertyImages.new(user, images_params)
      images_result = add_images.save_property_images
  
      Rails.logger.error("Images processing result: #{images_result}")
  
      render json: { PAF_KEY: images_result, status: true }
    else
      Rails.logger.error("Invalid format for images_params. Expected an array.")
      render json: { message: "Invalid format for images_params. Expected an array.", status: false }
    end
  end
  
  private
  
  def save_profile_photo(file)
    filename = File.basename(file)
    local_path = Rails.root.join('public', 'images', filename)
  
    FileUtils.cp(file, local_path)
  end

  
end
