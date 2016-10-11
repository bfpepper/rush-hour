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

      #need a way to reference client
      c1 = Client.find_by(identifier:params["IDENTIFIER"])

      #missing payload 400 bad request, if payload is Missing
      #??  can we call on this if they don't exist at all. Maybe .nil?
      if params[:payload].empty?
        status 400
        body "missing payload"


      #application not registered 403, if it doesn't correspond to an already existing client(identifier/rooturl pair)
      elsif c1.nil?
        status 403
        body "no client"

      #already received request 403 forbidden, if we already made that exact payload
      elsif Payload.already_exists?(params)
        status 403
        body "already received"


      #success 200 ok, for unique payload.
      else Payload.payload_constructor(params)
        status 200
      end
    end
  end
end
