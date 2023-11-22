class Api::V1::PropertyController < ApplicationController
    
  
  
  
   def get_property_details_by_id
         Rails.logger.error(" property Step 1")
         user = params[:user_account_id]
         page_no =params[:page_no]
         p_limit = params[:p_limit]
         p_order_col =params[:p_order_col]
         p_order_wise =params[:p_order_wise]
         Rails.logger.error(user)
         Rails.logger.error(page_no)
         Rails.logger.error(p_limit)
         Rails.logger.error(p_order_col)
         Rails.logger.error(p_order_col)
     
         result = UspKodieGetPropertyDetailsByUserId.new(user,page_no,p_limit,p_order_col,p_order_wise)
         result_data = result.get_property_details(request)
         Rails.logger.error("result_data")
         Rails.logger.error(result_data)
     
   
        render json: { property_details: result_data , status: true }
   
    end

    def delete_property_by_id
      Rails.logger.error(" property Step 1")
      property_id = params[:property_id]
      Rails.logger.error("property_id")
      Rails.logger.error(property_id)
    
      result = UspKodieDeletePropertyDetails.new(property_id)
      result_data = result.delete_property_by_id
      Rails.logger.error("result_data")
      Rails.logger.error(result_data)
    
      if result_data == "ID not Found"
        render json: { message: "Property ID Not Found", status: true }
      else
        render json: { message: "Property Deleted Successfully", status: true }
      end
    end


    def get_Details_by_filter
      Rails.logger.error("property_filter")
        property_filter = params[:property_filter]
        Rails.logger.error("1")
        user_account_id = params[:user_account_id]
        Rails.logger.error("2property_filter")
        page_no =params[:page_no]
        Rails.logger.error("3property_filter")
        limit =params[:limit]
        Rails.logger.error("4property_filter")
        order_col = params[:order_col]
        Rails.logger.error("5property_filter")
        order_wise =params[:order_wise]


        Rails.logger.error(property_filter)
        Rails.logger.error(page_no)
        Rails.logger.error(limit)
        Rails.logger.error(order_col)
        Rails.logger.error(order_wise)

        getproperty= UspKodieGetPropertyDetailByFilter.new(property_filter,user_account_id,page_no,limit,order_col,order_wise)
        get_all_details=getproperty.get_property_details_filter(request)

        Rails.logger.error(get_all_details)
        render json: { property_details: get_all_details, status: true }

    end  

    def add_property_details_archieve
      property_id =params[:property_id]
      Rails.logger.error(property_id)
      getproperty= UspKodieAddPropertyToArchieve.new(property_id)
      get_all_details=getproperty.add_property_archieve

      Rails.logger.error(get_all_details)
      render json: { message: get_all_details, status: true }
 
    end  

    def get_property_details_After_archieve_by_id
      Rails.logger.error(" property Step 1")
      user = params[:user_account_id]
      page_no =params[:page_no]
      p_limit = params[:p_limit]
      p_order_col =params[:p_order_col]
      p_order_wise =params[:p_order_wise]
      Rails.logger.error(user)
      Rails.logger.error(page_no)
      Rails.logger.error(p_limit)
      Rails.logger.error(p_order_col)
      Rails.logger.error(p_order_col)
  
      result = UspKodieGetPropertyToAfterArchieve.new(user,page_no,p_limit,p_order_col,p_order_wise)
      result_data = result.get_property_details(request)
      Rails.logger.error("result_data")
      Rails.logger.error(result_data)
  

     render json: { property_details: result_data , status: true }

 end
     
end
