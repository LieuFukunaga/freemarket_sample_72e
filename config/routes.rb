Rails.application.routes.draw do
  $date = Time.now.to_s

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  root "products#index"

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  resources :products do
    collection do
      get "search"
      # json形式でのレスポンスを指定
      get 'get_category_children'     , defaults: {format: 'json'}
      get 'get_category_grandchildren', defaults: {format: 'json'}
    end
    member do
      get 'get_category_parent'       , defaults: {format: 'json'}
      get "pay"
      get "buy"
      get "create_like"
      post "create_comment"
      delete "destroy_image"
      delete "destroy_like"
    end
  end

  resources :users, only: [:show] do
    member do
      get "show_like"
      get 'authenticate'
      get 'telephone'
      get 'select'
      get 'registration'
      get 'result'
    end
  end
end