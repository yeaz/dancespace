DanceSpace::Application.routes.draw do
  
  resources :experiencelinks

  root 'home#index'
  
  get '/about' => 'home#about'

  devise_for :users,
  :controllers => {
    :registrations => 'users/registrations'
    }
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
    get 'signup', to: 'devise/registrations#new'
  end
  
  resources :users
  get 'user_settings', to: 'users#edit_profile'
  get 'random_user', to: 'users#get_random_user'
  
  resources :videos
  get 'get_it', to: 'videos#get_it'
  
  resources :experiences
  resources :studios do
    resources :events
  end

  get 'get_events_in_bounds', to: 'events#search'
  get 'get_studios_in_bounds', to: 'studios#search'
  
  resources :events do
    get 'set_location', to: 'events#set_location'
    get 'get_address', to: 'events#get_address'
    get 'get_coordinates', to: 'events#get_coordinates'
  end
  
  resources :studios, only: [:show] do
    get 'set_location', to: 'studios#set_location'
    get 'get_address', to: 'studios#get_address'
    get 'get_coordinates', to: 'studios#get_coordinates'
  end

  resources :events, only: [:index, :show, :edit, :update, :destroy]

  get 'eventsfeed', to: "home#eventsfeed"
  get 'studiosnearby', to: "home#studiosnearby"
  get 'eventsfeed_title', to: "home#load_eventsfeed_title"
  get 'studiosfeed_title', to: "home#load_studiosfeed_title"

  get 'studios_nearby', to: "studios#nearby"

  
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
