Rails.application.routes.draw do
    root to:"toppages#index"
    
    get "login",to: "sessions#new"
    post "login",to: "sessions#create"
    delete "logout",to: "sessions#destroy"
    
    get "signup", to: "users#new"
    get "search", to: "plans#search"
    get "plan_ranking", to: "plans#plan_ranking"
    resources :users, only:[:index, :show, :edit, :update, :create, :destroy] do
        member do
            get :likes
        end
    end
    
    get 'plans/reuse', to: 'plans#reuse'
    resources :plans
    resources :favorites, only: [:create, :destroy]    
    resources :comments, only: [:create, :destroy]        
end
