Rails.application.routes.draw do
  get 'get_subjects_list/:id', to: 'qualifications#get_subjects_list', as: :get_subjects_list
  get 'get_products_list/:id', to: 'subjects#get_products_list', as: :get_products_list
  get 'get-all', to: 'exams#get_all', as: :getall
  post 'remove-all', to: 'exams#remove_all', as: :removeall
  resources :countries
  resources :subjects
  resources :qualifications
  resource :exams, only: [:index]
  get 'exams(/*other)', to: 'exams#index', as: :exams
  root 'exams#index'
end
