Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users
  get 'users/:id' => 'users#show'
  get ':user_name' => 'posts#mypage'
  resources :posts do
    resources :comments, only: [:create, :edit, :destroy]
  end
  resources :likes, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
