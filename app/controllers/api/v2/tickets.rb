require "sinatra"

module API
  module V2
    class Tickets < Sinatra::Base
      before do
        headers "Content-Type" => "text/json"
        set_user
        set_project
      end

      get "/:id" do
        ticket = @project.tickets.find(params[:id])
        unless TicketPolicy.new(@user, ticket).show?
          halt 404, "The ticket you were looking for could not be found."
        end
        TicketSerializer.new(ticket).to_json
      end

      private
        def set_project
          @project = Project.find(params[:project_id])
        end

        def set_user
          if env["HTTP_AUTHORIZATION"].present?
            if auth_token = /Token token=(.*)/.match(env["HTTP_AUTHORIZATION"])[1]
            # we don't need the user we just need raise error if the user is not authenticated
              @user = User.find_by(api_key: auth_token)
              return @user if @user.present?
            end
          end

          unauthenticated!
        end

        def unauthenticated!
          halt 401, {error: "Unauthenticated"}.to_json
        end

        def params
          # merge the params of Sinatra with one env parameter
          hash = env["action_dispatch.request.path_parameters"].merge!(super)
          HashWithIndifferentAccess.new(hash) # generate a hash in which keys can be accessed by symbols or strings
        end
    end
  end
end
