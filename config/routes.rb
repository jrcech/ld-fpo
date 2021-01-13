Rails.application.routes.draw do
  get '/:search', to: 'homepage#search'

  root to: 'homepage#index'
end
