Rails.application.routes.draw do
  devise_for :users
  

	  resources :posts do
	  	resources :comments
	  	resources :likes
	  end


  resources :categories
  get 'welcome/index'
  root 'welcome#index'
  mount ActionCable.server, at: '/cable'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
