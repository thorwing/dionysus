Dionysus::Application.routes.draw do

  resources :cocktails

  resources :deals

  resources :articles, only: [:show, :index]

  resources :recipes

  resources :replies

  resources :topics

  resources :checks

  resources :reviews
  resources :wishes

  match "logout" => "sessions#destroy"
  match "login" => "sessions#new"
  match "sign_up" => "users#new"
  resource :sessions, only: [:new, :create, :destroy]

  put "nodes/:id/lock", to: "nodes#lock", as: :lock_node
  put "nodes/:id/unlock", to: "nodes#unlock", as: :unlock_node

  resources :beverages

  resources :brands

  resources :regions

  resources :grapes

  resources :wine, controller: :beverages, type: "Wine"
  resources :beer, controller: :beverages, type: "Beer"
  resources :whisky, controller: :beverages, type: "Whisky"
  resources :rum,  controller: :beverages, type: "Rum"
  resources :brandy,  controller: :beverages, type: "Brandy"
  resources :vodka,  controller: :beverages, type: "Vodka"
  resources :gin,  controller: :beverages, type: "Gin"
  resources :tequila,  controller: :beverages, type: "Tequila"
  resources :sake,  controller: :beverages, type: "Sake"
  resources :liqueur,  controller: :beverages, type: "Liqueur"
  resources :chineseliqueur,  controller: :beverages, type: "ChineseLiqueur"
  resources :whitespirit, controller: :beverages, type: "WhiteSpirit"

  resources :users

  resources :ranks

  resources :aocs

  resources :password_resets

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

  namespace :admin do
    root :to => "base#index"

    resources :articles
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
