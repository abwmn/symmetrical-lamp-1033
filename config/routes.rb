Rails.application.routes.draw do
  get 'customers/:id', to: 'customers#show', as: 'customer'
  post 'customers/:id/add_item', to: 'customers#add_item', as: 'add_item'

  get 'items', to: 'items#index', as: 'items'
end
