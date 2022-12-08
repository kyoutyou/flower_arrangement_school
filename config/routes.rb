Rails.application.routes.draw do
  devise_for :users, controllers: {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions',
  :passwords => 'users/passwords'
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"homes#top"
    get 'home/about'=>"homes#about", as: "about"
    get 'home/productions'=>"homes#productions", as: "production"
    get 'home/courses'=>"homes#courses", as: "courses"
    get 'home/calendar'=>"homes#calendar"
    resources :calendars,only:[:show]
  namespace :public do
    get 'users/unsubscribe'=>'users#unsubscribe'
    get 'users/withdraw'=>'users#withdraw'
    post 'contacts/confirm'=>"contacts#confirm"
    get 'contacts/thanks'=>"contacts#thanks"
    resources :customers,only:[:show,:edit,:update]
    resources :reservations,only:[:new, :create, :index,:edit,:update]
    resource :contacts,only:[:new,:creat]
  end
  namespace :admins do
    root to:"homes#top"
    resources :users,only:[:show,:edit,:update]
    resources :productions,only:[:edit,:update]
    resources :reservations,only:[:index,:new,:create]
  end
end
