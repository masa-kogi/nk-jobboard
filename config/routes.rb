Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_for :recruiters, controllers: {
    sessions:      'recruiters/sessions',
    passwords:     'recruiters/passwords',
    registrations: 'recruiters/registrations'
  }

  devise_for :employees, controllers: {
    sessions:      'employees/sessions',
    passwords:     'employees/passwords',
    registrations: 'employees/registrations'
  }

  resources :recruiters, path: '/recruiters', param: :username, only: [] do
    scope module: 'recruiters' do
      resources :jobs, only: [:index, :create, :new, :edit, :update, :destroy] do
        # resources :applicants, only: [:index, :show, :update]  # 追加
        collection do
          post :confirm
          get :fetch_recruiters, defaults: { format: 'json' }
        end
        member do
          patch :edit_confirm
        end
      end
    end
  end


  resources :jobs, module: 'employees', only: [:index, :show] do
    resources :job_applications, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end

  resources :jobs do
    resources :applicants, only: [:index, :show, :edit, :update]
  end

  resources :employees, param: :username, only: [] do
    resources :job_applications, module: 'employees', only: [:index, :show]
    resource :profile, module: 'employees', only: [:show, :edit, :update] do
      collection do
        post :edit_confirm
      end
    end
  end

  # resources :admins, only: [] do
  resources :admins, path: '/admins', param: :username, only: [] do
    scope module: 'admins' do
      resources :jobs, only: [:index, :show] do
      end
    end
  end

  root 'employees/jobs#index'


end
