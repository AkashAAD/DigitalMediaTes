Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :users do
        collection do
          post 'sign_up'
          post 'sign_in'
        end
      end
      resources :digital_content do 
        collection do 
          post 'create_movie'
          post 'create_season'
          post 'create_episode'
          post 'create_option'
          post 'create_library'
        end
      end
      resources :library do 
        collection do
          post 'create_library'
        end
      end
      resources :read_data do 
        collection do
          get 'movies'
          get 'seasons'
          get 'movies_seasons'
          get 'user_library'
          get 'movie_season'
          get 'movie_season_option'
        end
      end
    end
  end
end
