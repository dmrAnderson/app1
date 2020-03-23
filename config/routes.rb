Rails.application.routes.draw do
	root 'static_pages#home'
	
  get 'contact', to: 'static_pages#contact'
	
	resources :users, except: [:new]

	get    'signup',  to: 'users#new'
	get    'signin',  to: 'sessions#new'
	post   'signin',  to: 'sessions#create'
	delete 'signout', to: 'sessions#destroy'
end
