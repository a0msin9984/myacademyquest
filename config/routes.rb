Rails.application.routes.draw do
  # Health check (render 200 OK ถ้า server ทำงานปกติ)
  get "up" => "rails/health#show", as: :rails_health_check

  # Root ไปที่ tasks#index
  root "tasks#index"

  # Tasks CRUD (index, create, update, destroy) + toggle
  resources :tasks, only: [ :index, :create, :update, :destroy ] do
    member do
      patch :toggle
    end
  end

  # Bragdocs page
  get "bragdocs", to: "bragdocs#index", as: :bragdocs_index

  get "*path", to: redirect("/"), via: :all
end
