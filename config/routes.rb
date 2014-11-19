Rails.application.routes.draw do


root 'access#login'

#Users
resources :users, only: [:new, :create, :show, :edit] do

  #Projects
  resources :projects,  only: [:show, :new, :create, :edit]

end

#tags
resources :tag, only: [:show, :create]

end
