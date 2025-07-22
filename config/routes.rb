Rails.application.routes.draw do

  devise_for :users

  resources :admins do
    collection do
      post 'create_student'
      post 'create_teacher'
      get 'profile'
    end
    member do
      get 'show_student'
      get 'edit_student'
      patch 'update_student'
      delete 'delete_student'
      get 'show_teacher'
      get 'edit_teacher'
      patch 'update_teacher'
      delete 'delete_teacher'
    end
  end

  resources :students

  resources :teachers do
    collection do
      get 'profile', to: 'teachers#index'
    end
  end

  resources :notices do
    member do
      patch 'like'
    end
  end

  resources :grievances do
    member do
      patch 'resolve'
      patch 'like'
    end

    resources :replies
  end


  # get 'teacher' to:'teachers#profile'
  get 'notice', to: 'notice#index'
  get "contact", to: "contact#index"
  get 'about', to: "about#index"
  get 'alumni', to: "alumni#index"


  get '/donate', to: 'donations#new'
  post '/donate', to: 'donations#create'
  get '/donate/execute', to: 'donations#execute'
  get '/donate/cancel', to: 'donations#cancel'


  resources :tests do
    resources :questions
    member do
      get 'attempt'
      post 'submit_attempt'
    end
  end
  
  resources :attempts

  resources :doubts

  resources :messages, only: [:index]

  root "home#index"
end
