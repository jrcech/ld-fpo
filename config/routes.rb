# frozen_string_literal: true

Rails.application.routes.draw do
  get '/:search', to: 'homepage#search'
  get '/subject/:id', to: 'subject#show', as: :subject

  get '/coi/:id', to: 'charts#coi', as: :coi_charts
  get '/coi_sanctions/:id', to: 'charts#coi_sanctions', as: :coi_sanctions_charts
  get '/coi_instruments/:id', to: 'charts#coi_instruments', as: :coi_instruments_charts

  root to: 'homepage#index'
end
