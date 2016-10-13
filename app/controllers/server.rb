module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      Client.create(identifier: params[:identifier], root_url: params[:rootUrl])
    end
  end
end
