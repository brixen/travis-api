require 'travis/api/app'

class Travis::Api::App
  class Endpoint
    class Home < Endpoint
      set :prefix, '/'
      set :client_config,
        host: Travis.config.host,
        shorten_host: Travis.config.shorten_host,
        assets: Travis.config.assets,
        pusher: { key: Travis.config.pusher.try(:key) }

      # Landing point. Redirects web browsers to [API documentation](#/docs/).
      get '/' do
        pass if settings.disable_root_endpoint?
        redirect to('/docs/') if request.preferred_type('application/json', 'text/html') == 'text/html'
        { 'hello' => 'world' }
      end

      # Simple endpoints that redirects somewhere else, to make sure we don't
      # send a referrer.
      #
      # Parameters:
      #
      # * **to**: URI to redirect to after handshake.
      get '/redirect' do
        halt 400 unless params[:to] =~ %r{^https?://}
        redirect params[:to]
      end

      # Provides you with system info:
      #
      #     {
      #       config: {
      #         host: "travis-ci.org",
      #         shorten_host: "trvs.io",
      #         pusher: { key: "dd3f11c013317df48b50" },
      #         assets: {
      #           host: "localhost:3000",
      #           version: "asset-id",
      #           interval: 15
      #         }
      #       }
      #     }
      get '/config' do
        { config: settings.client_config }
      end
    end
  end
end
