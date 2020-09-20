Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/callback/geocode', to: 'geocode#show'
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
    end
  end
end
