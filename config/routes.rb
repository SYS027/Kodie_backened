Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
 
  namespace 'api' do
    namespace 'v1' do
      post 'signup', to: 'auth#signup'
      post 'signup_verifyotp', to: 'auth#Signup_Check'
      post '/login', to: 'session#login'
      get '/logout', to: 'session#logout'
      post 'step1', to: 'step1#index'
      post 'reset_password' , to: 'reset_password#reset_password'
      post 'lookup/step1' , to: 'look#index'
      post 'current_user' , to: 'session#current_user'
      post 'reset_password1' , to: 'reset_password#step_1_reset_password'
      post 'reset_password2' , to: 'reset_password#step_2_reset_password'
    end
  end
end
