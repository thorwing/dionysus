Dionysus::Application.routes.draw do
  resources :lists

  resources :comments

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {registrations: "registrations"} do
    get "crop", to: "registrations#crop", as: :crop_avatar
  end

  match "sign_up" => "users#new"
  resources :users do
    resources :locations
    collection do
      get :search
    end
  end

  match 'activities' => 'users#activites', as: :activities

  mount RedactorRails::Engine => '/redactor_rails'

  resources :cocktails
  resources :recipes

  resources :deals

  resources :articles

  resources :topics
  resources :replies

  resources :reviews
  resources :wishes

  put "nodes/:id/lock", to: "nodes#lock", as: :lock_node
  put "nodes/:id/unlock", to: "nodes#unlock", as: :unlock_node

  put "follow", to: "follows#follow", as: :follow
  put "unfollow", to: "follows#unfollow", as: :unfollow

  resources :brands

  resources :regions

  resources :grapes

  resources :packages

  resources :beverages

  resources :wine, controller: :beverages, type: "Wine"
  resources :beer, controller: :beverages, type: "Beer"
  resources :whisky, controller: :beverages, type: "Whisky"
  resources :rum,  controller: :beverages, type: "Rum"
  resources :brandy,  controller: :beverages, type: "Brandy"
  resources :vodka,  controller: :beverages, type: "Vodka"
  resources :gin,  controller: :beverages, type: "Gin"
  resources :tequila,  controller: :beverages, type: "Tequila"
  resources :japanese_spirit,  controller: :beverages, type: "JapaneseSpirit"
  resources :liqueur,  controller: :beverages, type: "Liqueur"
  resources :chinese_liqueur,  controller: :beverages, type: "ChineseLiqueur"
  resources :white_spirit, controller: :beverages, type: "WhiteSpirit"
  resources :rice_wine, controller: :beverages, type: "RiceWine"

  resources :ranks

  resources :password_resets

  resources :votes do
    collection do
      put :up
      put :down
    end
  end

  resources :messages
  resources :conversations
  resources :notifications do
    collection do
      get :count
    end
    member do
      put :read
    end
  end

  resources :complains

  resources :search

  resources :hornets do
    collection do
      get :fetch
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
