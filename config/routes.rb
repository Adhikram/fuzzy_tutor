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
      jsonapi_resources :courses, only: %i[show create destroy update], param: :slug do
        collection do
          get :active_courses
        end
        member do
          get :papers
        end
      end
      jsonapi_resources :papers, only: %i[show create destroy update] do
        member do
          get :preview
        end
      end
      jsonapi_resources :paper_elements, only: %i[index show create destroy update]
      jsonapi_resources :paper_submissions, only: %i[index show create destroy update]
    end
  end
end
