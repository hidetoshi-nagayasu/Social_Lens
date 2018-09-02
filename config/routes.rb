Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  get 'users/:id'  => 'users#show'
  get 'posts'      => 'posts#index'
  get ':user_name' => 'users#mypage'
  resources :posts do
    get :search, on: :collection
    resources :comments
  end
  resources :likes, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers, :users_tweets
    end
  end
  resources :relationships, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
