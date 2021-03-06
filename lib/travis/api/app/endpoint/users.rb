require 'travis/api/app'

class Travis::Api::App
  class Endpoint
    # TODO should this be /profile?
    class Users < Endpoint
      # Gives information about the currently logged in user.
      #
      # Example:
      #
      #     {
      #       "user": {
      #         "name": "Sven Fuchs",
      #         "login": "svenfuchs",
      #         "email": "svenfuchs@artweb-design.de",
      #         "gravatar_id": "402602a60e500e85f2f5dc1ff3648ecb",
      #         "locale": "de",
      #         "is_syncing": false,
      #         "synced_at": "2012-08-14T22:11:21Z"
      #       }
      #     }
      get '/', scope: :private do
        respond_with current_user
      end

      get '/permissions', scope: :private do
        respond_with service(:users, :permissions), type: :permissions
      end

      put '/:id?', scope: :private do
        respond_with update(params[:user])
      end

      post '/sync', scope: :private do
        respond_with service(:users, :sync)
      end
    end
  end
end
