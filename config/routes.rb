Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }
  root 'posts#index'


  authenticate :user do
    root 'posts#index', as: :authenticated_root
  end
  
  resources :posts do
    resources :comments, only: [:create, :destroy, :edit]
    resources :likes, only: [:create, :destroy]
   
    member do
      post 'like' # For liking a post
      delete 'unlike' # For unliking a post (optional)
    end

    collection do
      get 'search'
    end
  end
end