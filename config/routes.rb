Rails.application.routes.draw do
  get '/', to: 'application#health_check'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post '/sign_in', to: 'auth#sign_in'
      get '/forget_password', to: 'auth#forget_password'
      post '/reset_password', to: 'auth#reset_password'
      post '/validate_otp', to: 'auth#validate_otp'

      resources :specialties, only: %i[index]
      resources :diagnoses, only: %i[index]
      resources :targeted_skills, only: %i[index]

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

      resources :centers, only: %i[create update] do
        member do
          post :invite_doctor
          post :assign_doctor
          put :make_doctor_admin
          post :add_child
          put :edit_child
          post :add_headset
          put :edit_headset
        end
      end

      post 'centers/:center_id/add_modules', to: 'centers/software_modules#add_modules'
      put 'centers/:center_id/assign_module_child', to: 'centers/software_modules#assign_module_child'
      put 'centers/:center_id/unassign_module_child', to: 'centers/software_modules#unassign_module_child'
      put 'centers/:center_id/assign_doctor_child', to: 'centers/doctors#assign_doctor_child'
      put 'centers/:center_id/unassign_doctor_child', to: 'centers/doctors#unassign_doctor_child'
      get 'centers/:center_id/all_doctors', to: 'centers/doctors#index'

      namespace :centers do
        scope ':center_id' do
          resources :doctors, only: %i[index show] do
            member do
              put :assign_doctor_child
              put :unassign_doctor_child
            end
          end
          resources :sessions, only: %i[index show]
          resources :kids, controller: 'children', only: %i[index show]
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
      end

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
      end

      resources :headsets, only: %i[] do
        member do
          get :free_headset unless Rails.env.production?
        end
      end
    end
  end
end
