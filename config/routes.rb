Rails.application.routes.draw do
  devise_for(:users, controllers: { registrations: "registrations" })

  resources(:users, only: [:show])
  resources(:events) do 
    member do
      # https://www.rubydoc.info/docs/rails/4.1.7/ActionDispatch/Routing/Mapper/Resources
      post("attendance", to: "attendances#enroll")
      delete("attendance", to: "attendances#unenroll")
    end
  end

  root("events#index")

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
