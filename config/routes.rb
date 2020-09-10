Rails.application.routes.draw do
  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }, controllers: {
  sessions: 'users/sessions'
  }

  resources :tests, only: :index do
    resources :questions, only: :index, shallow: true, except: :index do
      resources :answers, only: :index, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      resources :questions, shallow: true, expect: :index do
        resources :answers, shallow: true, expect: :index
      end
    end
    resources :gists, only: :index
  end
end
