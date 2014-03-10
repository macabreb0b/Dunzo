Projection::Application.routes.draw do
  root to: "sessions#new"
  resources :users, except: [:index]

  resources :clients do
    resources :projects, only: [:index, :new]
  end

  resources :projects, except: [:index, :new] do
    member do
      post 'change_status', to: "projects#change_status"
    end
    resources :deliverables, only: [:index, :new, :create]
  end

  get 'new_project', to: "projects#new" # for creating a project without selecting a client first

  resources :deliverables, except: [:index, :new, :create] do
    member do
      post 'add_hour', to: "deliverables#add_hour"
      post 'remove_hour', to: "deliverables#remove_hour"
      post 'complete', to: "deliverables#complete"
    end
  end

  resources :notes, only: [:new, :create, :show, :destroy, :edit, :update]

  resource :session, only: [:new, :create, :destroy]
end
