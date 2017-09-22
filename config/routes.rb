Rails.application.routes.draw do
	get 'student', to: 'student#index'
  get 'instructor', to: 'instructor#index'
  get 'admin', to: 'admin#index'
  get 'home', to: 'admin#index'
  
  post 'admin/approve_user'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
end
