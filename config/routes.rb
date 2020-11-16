Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tracks
      resources :records
    end
  end

  root "home#index"
end
