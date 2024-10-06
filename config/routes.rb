require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username),
                                                ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(Rails.env.to_sym, :sidekiq_username))) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password),
                                                  ::Digest::SHA256.hexdigest(Rails.application.credentials.dig(Rails.env.to_sym, :sidekiq_password)))
  end
  mount Sidekiq::Web => '/sidekiq'

  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/sign_in', to: 'auth#sign_in'
      get '/forget_password', to: 'auth#forget_password'
      post '/reset_password', to: 'auth#reset_password'
      post '/validate_otp', to: 'auth#validate_reset_password_otp'
      post '/validate_reset_password_otp', to: 'auth#validate_reset_password_otp'
      post '/doctors/:id/validate_otp', to: 'auth#validate_email_otp'
      put '/doctors/:id/resend_otp', to: 'auth#resend_email_otp'

      resources :specialties, only: %i[index show]
      resources :diagnoses, only: %i[index show]
      resources :targeted_skills, only: %i[index show]

      resources :sessions, only: %i[index show create] do
        member do
          put :add_module
          put :add_doctor
          put :end_session
          post :add_comment
          put :add_evaluation
          put :add_note_and_evaluation
          post :add_evaluation_file
        end
      end

      resources :headsets, only: %i[index show] do
        member do
          get :free_headset unless Rails.env.production?
        end
      end

      # CENTER ENDPOINTS
      resources :centers, only: %i[index show create update] do
        member do
          post :add_child
          put :edit_child
        end
      end

      # software module redirect
      post 'centers/:center_id/add_modules', to: 'centers/software_modules#add_modules'
      put 'centers/:center_id/assign_module_child', to: 'centers/software_modules#assign_module_child'
      put 'centers/:center_id/unassign_module_child', to: 'centers/software_modules#unassign_module_child'

      # doctors redirect
      put 'centers/:center_id/assign_doctor_child', to: 'centers/doctors#assign_doctor_child'
      put 'centers/:center_id/unassign_doctor_child', to: 'centers/doctors#unassign_doctor_child'
      get 'centers/:center_id/all_doctors', to: 'centers/doctors#index'
      post 'centers/:center_id/invite_doctor', to: 'centers/doctors#invite_doctor'
      post 'centers/:center_id/assign_doctor', to: 'centers/doctors#assign_doctor'
      post 'centers/:center_id/edit_doctor', to: 'centers/doctors#edit_doctor'
      post 'centers/:center_id/make_doctor_admin', to: 'centers/doctors#make_doctor_admin'

      # headsets redirect
      post 'centers/:center_id/add_headset', to: 'centers/headsets#add_headset'
      put 'centers/:center_id/edit_headset', to: 'centers/headsets#edit_headset'

      # children redirect
      post 'centers/:center_id/add_child', to: 'centers/children#add_child'
      put 'centers/:center_id/edit_child', to: 'centers/children#edit_child'

      namespace :centers do
        scope ':center_id' do
          resources :doctor_centers, only: %i[index show]
          resources :doctors, only: %i[index show] do
            collection do
              post :invite_doctor
              put :make_doctor_admin
              post :assign_doctor
            end
            member do
              put :edit_doctor
              put :assign_doctor_child
              put :unassign_doctor_child
            end
          end
          resources :sessions, only: %i[index show] do
            collection do
              get :evaluations
            end
          end
          resources :kids, controller: 'children', only: %i[index show] do
            collection do
              post :add_child
            end
            member do
              put :edit_child
            end
          end
          resources :modules, controller: 'software_modules', only: %i[index show] do
            collection do
              post :add_modules
            end
            member do
              put :assign_module_child
              put :unassign_module_child
            end
          end
          get :assigned_modules, controller: 'software_modules'
        end
        resources :headsets, only: %i[index show] do
          collection do
            post :add_headset
          end
          member do
            put :edit_headset
          end
        end
      end

      # ADMIN ENDPOINTS
      get 'admins/kids', to: 'admins/children#index'
      put 'admins/edit_child', to: 'admins/children#update'

      put 'admins/edit_doctor', to: 'admins/doctors#update'

      put 'admins/edit_headset', to: 'admins/headsets#update'
      delete 'admins/delete_headset/:headset_id', to: 'admins/headsets#destroy'

      post 'software_modules', to: 'admins/software_modules#create'
      put 'software_modules/:id', to: 'admins/software_modules#update'

      post 'admins/assign_center_headset/:center_id', to: 'admins/centers#assign_center_headset'
      post 'admins/assign_center_module', to: 'admins/centers#assign_center_module'

      post 'admins/send_otp', to: 'admins/otps#send_otp'

      namespace :admins do
        resources :doctors, only: %i[index show update]
        resources :children, only: %i[index show update]
        resources :software_modules, only: %i[index show create update]
        resources :centers, only: %i[index show] do
          member do
            get :session_evaluations
          end
          collection do
            post :assign_center_module
            post 'assign_center_headset/:center_id', to: 'centers#assign_center_headset'
          end
        end
        resources :specialties, only: %i[index show]
        resources :headsets, only: %i[index show update destroy]
        resources :otps, only: %i[] do
          collection do
            post :send_otp
          end
        end
        resources :targeted_skills, only: %i[index show]
        resources :diagnoses, only: %i[index show]
      end

      # DOCTOR ENDPOINTS
      get 'doctors/home_centers', to: 'doctors/centers#home_centers'
      get 'doctors/center_statistics', to: 'doctors/centers#center_statistics'
      get 'doctors/center_vr_minutes', to: 'doctors/centers#center_vr_minutes'

      namespace :doctors do
        resources :centers, only: %i[index show] do
          collection do
            get :home_centers
          end
          member do
            get :center_statistics
            get :center_vr_minutes
          end
        end
      end

      resources :doctors, only: %i[index show create update] do
        collection do
          post :complete_profile
          get :center_assigned_children
          get :center_headsets
          get :center_child_modules
          get :center_child_doctors
          get :center_child_sessions
          get :home_doctors
          get :home_kids
          get :sessions_percentage
          get :kids_percentage
        end
      end
    end
  end
end
