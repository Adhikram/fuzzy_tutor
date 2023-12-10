Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      jsonapi_resources :users, only: %i[show update create] do
        collection do
          get :me
          post :login
          delete :logout
        end
      end
    end
  end
end
