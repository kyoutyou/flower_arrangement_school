Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"homes#top"
    get 'home/about'=>"homes#about", as: "about"
    get 'home/production'=>"homes#production", as: "production"
    get 'home/course'=>"homes#course", as: "course"
  namespace :public do
    get 'users/unsubscribe'=>'users#unsubscribe'
    get 'users/withdraw'=>'users#withdraw'
    resources :users,only:[:show,:edit,:update]
    resources :reservations,only:[:index,:edit,:update]
  end

  namespace :admin do
    root to:"homes#top"
    resources :users,only:[:show,:edit,:update]
    resources :productions,only:[:edit,:update]
    resources :reservations,only:[:index,:new,:create]
  end
end
