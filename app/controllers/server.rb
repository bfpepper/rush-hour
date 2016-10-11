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
      if params[:payload].nil?
        status 400
        body "missing payload"
      elsif Client.find_by(identifier:params["IDENTIFIER"]).nil?
        status 403
        body "no client"
      elsif
        Payload.already_exists?(params)
        status 403
        body "already received"
      else
        Payload.payload_constructor(params)
        status 200
        body "payload created"
      end
    end

    get '/sources/:IDENTIFIER' do
      @client = Client.find_by(identifier:params["IDENTIFIER"])
    
      if @client.nil?
        erb :'clients/no_client'
      elsif @client.payloads.empty?
        erb :'clients/no_payloads'
      else
        erb :"clients/show"
      end
    end
  end
end
