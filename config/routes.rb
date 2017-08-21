Rails.application.routes.draw do

  namespace :admin do
    root 'application#index'
    resources :projects, only: [:new, :create, :destroy]
    resources :states, only: [:index, :new, :create] do
      member do
        get :make_default
      end
    end
    # each user has a new action called :archive can be
    # accessed through a PATCH request
    resources :users do
      member do
        patch :archive # archive_user_path
      end
    end
  end

  devise_for :users
  root 'projects#index'

  # nested resources
  resources :projects, only: [:index, :show, :edit, :update] do
    resources :tickets do
      collection do
        get :search # search_project_tickets_path
      end

      member do
        post :watch
      end
    end
  end

  resources :attachments, only: [:new, :show]
  # empty array means ticket is only used in conjunction with comments
  # no non-nested, standalone tickets url will be recognized
  resources :tickets, only: [] do
    resources :comments, only: [:create]
    resources :tags, only: [] do
      member do
        # delete method in html corresponds to remove route prefix
        # remove_ticket_tag_path, also the action name in TagsController
        delete :remove
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
