Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    namespace :api do
      resources :tasks do
        member do
          post 'assign'
          put 'progress'
        end
      end
      resources :users do
        get 'tasks'
      end
      get 'tasks/overdue', to: 'tasks#overdue'
      get 'tasks/status/:status', to: 'tasks#by_status'
      get 'tasks/completed', to: 'tasks#completed_within_range'
      get 'tasks/statistics', to: 'tasks#statistics'
    end
end
