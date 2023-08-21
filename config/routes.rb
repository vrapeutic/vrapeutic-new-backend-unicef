Rails.application.routes.draw do
  resources :doctors
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :specialties, only: %i[index]
      resources :doctors
    end
  end
end
