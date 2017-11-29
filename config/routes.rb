Rails.application.routes.draw do
  resources :lines do
    collection do
      post :set_controller
    end
  end
  ## Routes for devise
  devise_for(
    :users,
    controllers: { sessions:  'users/sessions', registrations: 'users/registrations',
                   passwords: 'users/passwords', confirmations: 'users/confirmations' },
    path: '',
    path_names: { sign_in:  'sign_in', sign_up:  'sign_up', sign_out: 'sign_out' }
  )

  post  'lines/new_form',        to: 'lines#new_form',  as: :lines_new_form
  post  'lines/change_form',        to: 'lines#change_form',  as: :lines_change_form
  get   'profile',        to: 'profiles#show',  as: :profile
  get   'profile/edit',   to: 'profiles#edit',  as: :edit_profile
  patch 'profile/update', to: 'profiles#update', as: :update_profile
  get   'profile/company-setting',        to: 'profiles#company_setting',         as: :company_setting
  patch 'profile/update-company-setting', to: 'profiles#update_company_setting', as: :update_company_setting

  resources :users
  resources :projects
  resources :tasks do
    collection do
      get 'filter'
    end
  end
  resources :hours
  resources :customers
  resources :companies
  resources :items

  # Static Pages
  get 'contact-us', to: 'static_pages#contact_us',  as: :contact_us_path
  get 'about-us',   to: 'static_pages#about_us',    as: :about_us_path
  get 'faq',        to: 'static_pages#faq',         as: :faq

  get 'dashboard', to: 'welcome#dashboard', as: :dashboard
  root 'welcome#index'
end
