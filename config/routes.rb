Rails.application.routes.draw do
  devise_for(:users, controllers: { registrations: "registrations" })

  root("events#index")

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
