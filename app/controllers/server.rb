module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      if params[:identifier].nil? || params[:rootUrl].nil?
        status 403
        body "Missing Paramaters"
      elsif Client.find_by(identifier: params[:identifier], root_url: params[:rootUrl])
        status 403
        body "Identifier Already Exists"
      elsif Client.create(identifier: params[:identifier], root_url: params[:rootUrl])
        status 200
        result = {"identifier": params["identifier"]}.to_json
        body result
      end
    end

    post '/sources/:IDENTIFIER/data' do
      p1 = Payload.payload_constructor(params)
      client = Client.find_by(identifier: params[:IDENTIFIER])
      if !client
        status 403
        body "Client doesn't exist."
      elsif Payload.already_exists?(params, client.id)
      status 403
      body "This is already entered"
    else
    end
  end
end
