class Api::V1::VerificationController < ApplicationController
  require 'open-uri'
  require 'fileutils'
   
  def profile_photo
    @profile_photo = params[:profile_photo]
    
    Rails.logger.error("temp_file_path")
    Rails.logger.error(@temp_file_path)
    Rails.logger.error("temp_file_path2")
    @user = params[:user]
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @physical_address = params[:physical_address]
    @organisation_name = params[:organisation_name]
    @referral_code = params[:referral_code]
    @describe_yourself = params[:describe_yourself]
    @property_manage = params[:property_manage]
    @kodie_help = params[:kodie_help]
    @location =params[:location]
    @location_longitude = params[:location_longitude]
    @location_latitude =params[:location_latitude]
    @islocation =params[:islocation]
    @property_description =params[:property_description]
    @property_type =params[:property_type]
    @key_features =params[:key_features]
    @additional_features =params[:additional_features]
    Rails.logger.error(@profile_photo)
    Rails.logger.error(@first_name)
    Rails.logger.error(@last_name)
    Rails.logger.error(@physical_address)
    Rails.logger.error(@organisation_name)
    Rails.logger.error(@referral_code)
  end

  def account_details
    {
      user: @user,
      first_name: @first_name,
      last_name: @last_name,
      physical_address: @physical_address,
      organisation_name: @organisation_name,
      referral_code: @referral_code,
      profile_photo: @original_filename,
      describe_yourself: @describe_yourself,
      property_manage: @property_manage,
      kodie_help: @kodie_help

    }
  end

  def property_details
    {
      location: @organisation_name,
      location_longitude: @organisation_name,
      location_latitude: @location_longitude,
      islocation: @islocation,
      property_description: @property_description,
      property_type: @property_type,
      key_features: @key_features,
      additional_features: @additional_features
      
    }
  end

  def create
    profile_photo
    Rails.logger.error("2")
    Rails.logger.error(@first_name)
    Rails.logger.error(@last_name)
  
    Rails.logger.error("2")
    Rails.logger.error("2")
  
    profile_photo_path = params[:profile_photo]
    if profile_photo_path.present?
      content_type =  @profile_photo.content_type
      @original_filename =  @profile_photo.original_filename
      @temp_file_path =  @profile_photo.tempfile.path
  
     
      save_profile_photo(profile_photo_path.tempfile)
 
      process_saved_file
  
      account_details['profile_photo'] = profile_photo_path.original_filename
    else
      render json: { message: "Profile photo is required", status: false }
      return
    end
  
    result = UspKodieSaveStepsJsonData.new(account_details, property_details)
    result_data = result.create_post_with_tags
  
    Rails.logger.error("result")
    Rails.logger.error(result_data)
  
   
    file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original_filename}"
  
    render json: { message: "Data Successfully Stored", profile_photo_path: file_url, profile_photo_name: @original_filename, status: true }
  end
  
  private
  
  def save_profile_photo(file)
    filename = File.basename(file)
    local_path = Rails.root.join('public', 'images', @original_filename)
    @full_path = local_path
    FileUtils.cp(file, local_path)
  end
  
  def process_saved_file
   
    saved_file_path = Rails.root.join('public', 'images', @original_filename)
    @saved_file = saved_file_path
    Rails.logger.error("saved_file_path")
    Rails.logger.error(saved_file_path)
    File.open(saved_file_path, 'r') do |file|
      file_content = file.read
      Rails.logger.error("File content:")
      Rails.logger.error(file_content)
    end
  end
  
  

  def account_details_params
    params[:account_details].present? ? JSON.parse(params[:account_details]) : {}
  end

  def property_details_params
    params[:property_details].present? ? JSON.parse(params[:property_details]) : {}
  end
end
