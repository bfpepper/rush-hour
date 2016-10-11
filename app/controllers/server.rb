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
      input = JSON.parse(params[:payload])

      #missing payload 400 bad request, if payload is Missing
      params[:payload].empty?
      #application not registered 403, if it doesn't correspond to an already existing client(identifier/rooturl pair)
      
      #already received request 403 forbidden, if we already made that exact payload
      if Payload.already_exists?(params)
        status 400
        body "Insufficient Payload"
      end


      #success 200 ok, for unique payload.
      Payload.payload_constructor(params)
    end
  end
end
