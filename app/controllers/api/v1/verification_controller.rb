class Api::V1::VerificationController < ApplicationController
  require 'open-uri'
  require 'fileutils'
   
  def profile_photo
 
    @email = params[:email]
    @profile_photo = params[:profile_photo]
    @phone_number = params[:phone_number]
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
    @p_longitude =params[:p_longitude]
    @p_latitude =params[:p_latitude]
    @State =params[:State]
    @Country =params[:Country]
    @City =params[:City]
    @autolist =params[:auto_list]
    @land_area =params[:land_area]
    @floor_size =params[:floor_size]
    @p_state =params[:p_state]
    @p_country= params[:p_country]
    @p_city = params[:p_city]
    Rails.logger.error(@profile_photo)
    Rails.logger.error(@first_name)
    Rails.logger.error(@last_name)
    Rails.logger.error(@physical_address)
    Rails.logger.error(@organisation_name)
    Rails.logger.error(@referral_code)
    Rails.logger.error(@phone_number)
    Rails.logger.error(@p_longitude)
    Rails.logger.error(@p_latitude)
    Rails.logger.error(@State)
    Rails.logger.error(@Country)
    Rails.logger.error(@City)
    Rails.logger.error(@autolist)
    Rails.logger.error(@land_area)
    Rails.logger.error(@floor_size)
    Rails.logger.error(@p_state)
    Rails.logger.error(@p_country)
    Rails.logger.error(@p_city)
  end
 
  def account_details
    {
     
      user: @user,
      first_name: @first_name,
      last_name: @last_name,
      phone_number: @phone_number,
      physical_address: @physical_address,
      p_longitude:@p_longitude,
      p_latitude: @p_latitude,
      State: @State,
      Country: @Country,
      City:@City,
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
      location: @location,
      p_state: @p_state,
      p_country: @p_country,
      p_city: @p_city,
      location_longitude: @location_longitude,
      location_latitude: @location_latitude,
      islocation: @islocation,
      property_description: @property_description,
      property_type: @property_type,
      key_features: @key_features,
      floor_size: @floor_size,
      land_area: @land_area,
      additional_features: @additional_features,
      auto_list:@autolist
    }
  end
 
  def create
    profile_photo

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
   
    payload = {
      email: @email,
      exp: 1.hour.from_now.to_i
    }
    token=JwtService.generate_token(payload)
    Rails.logger.error(token)
    response.headers['Authorization'] = "Bearer #{token}"
    result = UspKodieSaveStepsJsonData.new(account_details, property_details, @user,@email,token,1,1,)
    result_data = result.create_post_with_tags
    Rails.logger.error(result_data)
    Rails.logger.error("result")
 
 
    # result=UspKodieSetSignupDetailsService.new(@user,@email,token,"1","1")
    # details= result.sp_signup_details
    # Rails.logger.error("details-->")
    # Rails.logger.error(details)
 
   
    file_url = "#{request.protocol}#{request.host_with_port}/images/#{@original_filename}"
   
    render json: { message: "Data Successfully Stored",Login_details: result_data , profile_photo_path: file_url, profile_photo_name: @original_filename, status: true }
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
