Rails.application.routes.draw do
  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/sign_in', to: 'auth#sign_in'
      get '/forget_password', to: 'auth#forget_password'
      post '/reset_password', to: 'auth#reset_password'

      resources :specialties, only: %i[index]

      resources :diagnoses, only: %i[index]

      resources :targeted_skills, only: %i[index]

      resources :software_modules, only: %i[index create update]

      resources :sessions, only: %i[create] do
        member do
          # post :resend_otp
          # put :validate_otp
          put :add_module
          put :add_doctor
          put :end_session
          post :add_comment
          put :add_evaluation
          put :add_note_and_evaluation
          post :add_attention_performance
          # post :add_attention_performance_modules
        end
      end

      resources :admins, only: %i[] do
        collection do
          post :send_otp
          put :edit_child
          put :edit_doctor
          get :doctors
          get :centers
          get :kids
          get :headsets
          post :assign_center_module
          put :edit_headset
          delete '/delete_headset/:headset_id' => 'admins#delete_headset'
          post '/assign_center_headset/:center_id' => 'admins#assign_center_headset'
        end
      end

      namespace :centers do
        scope ':center_id' do
          resources :doctors, only: %i[index show]
          resources :sessions, only: %i[index show]
          resources :kids, controller: 'children', only: %i[index show]
          resources :modules, controller: 'software_modules', only: %i[index show]
          get :assigned_modules, controller: 'software_modules'
        end
      end

      resources :headsets, only: %i[] do
        member do
          get :free_headset unless Rails.env.production?
        end
      end

      resources :centers, only: %i[create update] do
        member do
          post :invite_doctor
          post :assign_doctor
          # put :edit_doctor
          put :make_doctor_admin
          post :add_child
          put :edit_child
          post :add_modules
          put :assign_module_child
          put :unassign_module_child
          put :assign_doctor_child
          put :unassign_doctor_child
          post :add_headset
          put :edit_headset
          get :all_doctors
        end
      end

      resources :doctors, only: %i[create update] do
        member do
          post :validate_otp
          put :resend_otp
        end
        collection do
          post :complete_profile
          get :centers
          get :center_assigned_children
          get :center_headsets
          get :center_child_modules
          get :center_child_doctors
          get :center_child_sessions
          get :home_centers
          get :home_doctors
          get :home_kids
          get :center_statistics
          get :center_vr_minutes
          get :child_session_performance_data
          get :sessions_percentage
          get :kids_percentage
        end
      end
    end
  end
end
