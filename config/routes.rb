Rails.application.routes.draw do
	root                  'static_pages#home'
  get    'contact', to: 'static_pages#contact'
	get    'signup',  to: 'users#new'
	get    'signin',  to: 'sessions#new'
	post   'signin',  to: 'sessions#create'
	delete 'signout', to: 'sessions#destroy'
	resources :users, except: [:new] do
		get 'following', 'followers', on: :member
	end
	resources :posts,               only: [:create, :destroy]
	resources :password_resets,     only: [:new, :create, :edit, :update]
	resources :account_activations, only: [:edit]
end
