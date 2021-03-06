Rails.application.routes.draw do
  resources :pharmacy_benifits
  resources :benefits
  api_constraints = if Rails.env.production?
    {subdomain: 'api'}
  else
    {}
  end
  devise_for :users, :controllers => {sessions: 'sessions', registrations: 'registrations'}
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post 'reset_password' => 'authentication#reset_password'
      post 'invite_user' => 'authentication#invite_user'
      post 'auth_user' => 'authentication#authenticate_user'
      put 'password' => 'authentication#update_password'
      delete 'sign_out' => 'authentication#log_out'
      post 'forgot_password' => 'authentication#forgot_password'
      resources :users do
        member do
          get :unassociate
          get :isAdmin
        end
        collection do
          get :roles
        end
      end
      resources :drug_prices
      resources :pharmacies
      resources :drugs
      resources :pharmacy_edit_requests do
        member do
          get :approve
          get :deny
        end
      end
      resources :hcf_locations
      resources :survey_days
      resources :user_rewards
      resources :hcf_rewards
      resources :rewards
      resources :awards
      resources :contracted_pharmacies do
        collection do
          get :list
          get :prefix
        end
      end
      resources :hcf_pharmacies do
        collection do
          get :list
          get :prefix
        end
      end
      resources :answers do
        collection do
          get :prefix
        end
      end
      resources :questions
      resources :surveys do
        collection do
          post :text_patient
          post :email_patient
        end
      end
      resources :health_care_facilities do
        member do
          get :pharmacies
          get :contracted
          get :map
          get :seed_clinic
          get :stats
        end
        collection do
          get :prefix
        end
      end
      resources :dni_pharmacies do
        collection do
          get :prefix
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
