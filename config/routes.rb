Rails.application.routes.draw do
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'portfolio' => 'static_pages#portfolio'

  get 'drafts' => 'posts#drafts'

  resources :comments #probably delete this

  devise_for :commenters, 
    controllers: {omniauth_callbacks: "omniauth_callbacks" }

  devise_for :admins

  resources :posts do
    resources :comments
  end

  root to: "posts#index"
end
