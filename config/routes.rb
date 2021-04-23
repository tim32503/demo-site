Rails.application.routes.draw do
  resources :users, only: [:create] do
    collection do
      get :sign_up, action: 'new'
    end
  end

  resources :sessions, path: "users", only: [] do
    collection do
      get :sign_in, action: 'new'
      post :sign_in, action: 'create'
      delete :sign_out, action: 'destroy'
    end
  end

  resources :restaurants do
    resources :comments, shallow: true, only: [:create, :destroy] # 等同下方註解掉的兩行code
    # resources :comments, only: [:index, :new, :create]
  end
  # resources :comments, except: [:index, :new, :create]
  # = resources :comments, only: [:show, :update, :edit, :destroy]

  root "restaurants#index"
end
