Rails.application.routes.draw do
  resources :locations
  devise_for :users
  

	  resources :posts do
	  	resources :comments
	  	resources :likes
      collection do
        get :recent
        get :tagged_with
      end
	  end


  resources :categories
  resources :users, only: [:show, :edit, :update] do
    resources :locations
  end
  get '/users/:user_id/locations/:id/sua_diadiem' => 'locations#sua_diadiem', as: :sua_diadiem
  get 'community', to: "users#community", as: :community
  
  get 'welcome/index'
  root 'welcome#index'

  get '/tagged', to: "posts#tagged", as: :tagged

  get '/search' => 'posts#search', :as => 'search_page'

#test
  get '/tag', to: "posts#click_tag", as: :tag


  mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
