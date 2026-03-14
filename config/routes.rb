Rails.application.routes.draw do
  resources :depth_charts do
    collection do
      get "position/:position/edit", to: "depth_charts#edit_position", as: "edit_position"
      patch "position/:position", to: "depth_charts#update_position", as: "update_position"
    end
  end
  resources :events
  get "statistics/index"
  get "statistics/show"
  resources :players do
    resources :awards, shallow: true
  end
  resources :gameschedules do
    collection do
      get "get_id", to: "gameschedules#get_id", as: "get_id"
      get ":id/live", to: "gameschedules#live", as: "live_game"
      get ":id/last_updated", to: "gameschedules#last_updated", as: :game_last_updated
    end
  end
  resources :teams do
    collection do
      post "clear"
    end
  end
  resources :ballpark, only: [ :index ]
  scope module: :admin do
  # URL: /history/results/new  -> Controller: Admin::ResultsHistoriesController
  resources :results_histories, path: "history/results", only: [ :new, :create, :show ]
  resources :manager_histories, path: "history/manager", only: [ :new, :create, :show ]
  resources :player_histories, path: "history/player", only: [ :new, :create, :show ]
  # URL: /history/playoffs/:id -> Controller: Admin::PlayoffHistoriesController
  resources :playoff_histories, path: "history/playoffs", only: [ :new, :create, :show ]
  resources :histories, controller: "base_histories", only: [ :edit, :update, :destroy ] do
    collection do
      get "check_uniqueness"
    end
  end
  # URL: /histories/:id/edit   -> Controller: Admin::HistoriesController
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/schedule(/:year)(/:month)", to: "gameschedules#index", constraints: { year: /\d{4}/, month: /\d{2}/ }, defaults: {  year: Time.current.year, month: Time.current.strftime("%m") }, as: "schedule_by_month"
  get "/roster", to: "players#index", as: "roster"
  get "/statistics", to: "statistics#index", as: "statistics"
  get "/statistics/records", to: "statistics#records", as: "records"
  get "/statistics/:id(/:playoffs)/export", to: "statistics#export", as: "export"
  get "/statistics/:id(/:playoffs)", to: "statistics#show", constraints: { year: /\d{4}/ }, as: "statistic"
  get "/game/:id", to: "gameschedules#show", as: "game"
  get "/history", to: "histories#index", as: "history_index"
  get "/teams/clear"
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "gameschedules#home"
end
