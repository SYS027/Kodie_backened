Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'signup', to: 'auth#signup'
      post '/login', to: 'session#login'
      get '/logout', to: 'session#logout'
      post 'step1', to: 'step1#index'
      post 'reset_password' , to: 'session#reset_password'
      post 'lookup/step1' , to: 'look#index'
    end
  end
end
