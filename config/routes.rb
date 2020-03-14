Rails.application.routes.draw do
	get 'singup', to: 'users#new'
	get 'singin', to: 'sessions#new'
	post 'singin', to: 'sessions#create'
	get 'singout', to: 'sessions#destroy'
	resources :users, except: :new
	root 'users#index'
end
