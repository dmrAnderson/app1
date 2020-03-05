Rails.application.routes.draw do
	get 'users/new'
	post 'users/create'
	root 'users#index'
end
