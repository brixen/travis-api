require 'travis/api/app'

class Travis::Api::App
  class Endpoint
    class Builds < Endpoint
      get '/' do
        respond_with all(params)
      end

      get '/:id' do
        respond_with one(params)
      end

      # get '/repositories/:repository_id/builds' do   # v1
      # get '/repos/:repository_id/builds' do          # v2
      #   respond_with all(params)
      # end

      # get '/repositories/:repository_id/builds/1' do # v1
      #   respond_with all(params)
      # end

      # get '/:owner_name/:name/builds' do             # v1
      # get '/repos/:owner_name/:name/builds' do       # v2
      #   respond_with all(params)
      # end

      # get '/:owner_name/:name/builds/:id' do         # v1
      #   respond_with all(params)
      # end
    end
  end
end
