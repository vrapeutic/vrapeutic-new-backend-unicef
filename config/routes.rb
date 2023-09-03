Rails.application.routes.draw do  

  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post '/sign_in', to: 'doctors#sign_in'

      resources :specialties, only: %i[index]

      resources :diagnoses, only: %i[index]

      
      resources :centers, only: %i[create update] do
        member do
          post :invite_doctor
          post :assign_doctor
          put :edit_doctor
          put :make_doctor_admin
          post :add_child
        end
      end

      resources :doctors, only: %i[create] do
        member do
          post :validate_otp
          put :resend_otp
        end
       collection do
        post :complete_profile
       end
      end
    end
  end
end
