Rails.application.routes.draw do  

  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/sign_in', to: 'doctors#sign_in'
      resources :specialties, only: %i[index]
      
      resources :centers, only: %i[create update]

      resources :doctors, only: %i[create] do
        member do
          post :validate_otp
          put :resend_otp
        end
      end
    end
  end
end
