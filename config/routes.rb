Rails.application.routes.draw do
	get 'signup', to: 'users#new'
	get 'signin', to: 'sessions#new'
	post 'signin', to: 'sessions#create'
	get 'signout', to: 'sessions#destroy'
	resources :users, except: :new
	root 'users#index'
end
