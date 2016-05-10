Rails.application.routes.draw do

  # devise_for :users, controllers: {
  #       sessions: 'users/sessions',
  #       registrations: 'users/registrations'
  #     }

  # devise_for :users
  devise_for :users, :controllers => { :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/register" => "devise/registrations#new"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # get '/profile/index' => 'profile#index'

  resources :conversations

  match 'customers/:id/gig', to: 'customers#gig', via: [:get, :post], as: :customer_gig
  match 'customers/:id/listgigs', to: 'customers#listgigs', via: [:get], as: :customer_listgigs
  match 'customers/search', to: 'customers#search', via: [:get, :post]
  match 'customers/:id/emailgig/:gig', to: 'customers#emailgig', via: [:get, :post], as: :customer_email_gig
  resources :customers

  resources :galleries do
    resources :pictures
  end

  resources :messages

  match 'profile/index', to: 'profile#index', via: [:get, :post], as: :profile_index
  match 'profile/:id/edit', to: 'profile#edit', via: [:get, :post], as: :profile_edit
  match 'profile/:id/vitals', to: 'profile#vitals', via: [:get, :post], as: :profile_vitals
  match 'profile/:id/bio', to: 'profile#bio', via: [:get, :post], as: :profile_bio
  match 'profile/:id/experience', to: 'profile#experience', via: [:get, :post], as: :profile_experience
  match 'profile/:id/schedule', to: 'profile#schedule', via: [:get, :post], as: :profile_schedule

  resources :profile

  match 'providers/search', to: 'providers#search', via: [:get, :post]
  resources :providers

  match 'setup/create', to: 'setups#create', via: [:post], as: :setup_create
  match 'setup/:id/jobs', to: 'setups#jobs', via: [:get, :post], as: :setup_jobs
  match 'setup/:id/vitals', to: 'setups#vitals', via: [:get, :post], as: :setup_vitals
  match 'setup/:id/gig', to: 'setups#gigs', via: [:get, :post], as: :setup_gigs
  match 'setup/:id/bio', to: 'setups#bio', via: [:get, :post], as: :setup_bio
  match 'setup/:id/experience', to: 'setups#experience', via: [:get, :post], as: :setup_experience
  match 'setup/:id/schedule', to: 'setups#schedule', via: [:get, :post], as: :setup_schedule
  match 'setup/thankyou', to: 'setups#thankyou', via: [:get, :post], as: :setup_thankyou

  resources :setups, controller: 'setups', as: 'setup'


  get '/about' => 'welcome#about'


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
