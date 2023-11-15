Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
 
  namespace 'api' do
    namespace 'v1' do
      post 'user_signup', to: 'auth#signup'
      post 'user_signup_verifyotp', to: 'auth#Signup_Check'
      post 'user_login', to: 'session#login'
      post 'user_reset_password' , to: 'reset_password#reset_password'
      post 'lookup_details' , to: 'look#index'
      post 'user_reset_password_email_verify' , to: 'reset_password#step_1_reset_password'      
      post 'user_save_signup_account_details' , to: 'verification#create'
      post 'add_property_details', to: 'step1#index'
      get 'key_features', to: 'step1#get_key_features'
      post 'add_property_images', to: 'step1#add_property_images'
      post 'add_property_video', to: 'step1#add_property_video'
      post 'get_All_Property_details', to: 'step1#get_property_details'
      post 'get_property_details_by_id', to: 'property#get_property_details_by_id'
      delete 'delete_property_by_id', to: 'property#delete_property_by_id'
      put 'update_property_details', to: 'step1#update_property_detail'
    end
  end
end
