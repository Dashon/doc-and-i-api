Rails.application.routes.draw do
  post 'auth_user' => 'authentication#authenticate_user'
  root to: 'visitors#index'
  # devise_for :users
  # resources :users

  api_constraints = if Rails.env.production?
    {subdomain: 'api'}
  else
    {}
  end

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do
        member do
          get :unassociate
        end
      end
      resources :drug_prices
      resources :pharmacies
      resources :drugs
      resources :pharmacy_edit_requests
      resources :hcf_locations
      resources :user_rewards
      resources :hcf_rewards
      resources :rewards
      resources :awards
      resources :contracted_pharmacies do
        collection do
           get :prefix
        end
      end
      resources :hcf_pharmacies do
        collection do
          get :prefix
        end
      end
      resources :answers do
        collection do
          get :prefix
        end
      end
      resources :questions
      resources :surveys
      resources :health_care_facilities do
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
