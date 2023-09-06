Rails.application.routes.draw do  

  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post '/sign_in', to: 'doctors#sign_in'

      resources :specialties, only: %i[index]

      resources :diagnoses, only: %i[index]

      resources :targeted_skills, only: %i[index]

      resources :software_modules, only: %i[index create update]



      resources :admins, only: %i[] do
        collection do
          post :send_otp
          put :edit_child
          put :edit_doctor
        end
      end


      
      resources :centers, only: %i[create update] do
        member do
          post :invite_doctor
          post :assign_doctor
          # put :edit_doctor
          put :make_doctor_admin
          post :add_child
          # put :edit_child
          post :add_modules
          put :assign_module_child
          put :unassign_module_child
          put :assign_doctor_child
          put :unassign_doctor_child
          post :add_headset
          put :edit_headset
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
