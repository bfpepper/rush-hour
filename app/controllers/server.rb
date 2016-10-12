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
        body "Missing Payload"
      elsif Client.find_by(identifier:params["IDENTIFIER"]).nil?
        status 403
        body "No Client"
      elsif
        Payload.already_exists?(params)
        status 403
        body "Already Received"
      else
        Payload.payload_constructor(params)
        status 200
        body "Payload Created"
      end
    end

    get '/sources/:IDENTIFIER' do
      @client = Client.find_by(identifier:params["IDENTIFIER"])
      if @client.nil?
        body "Client doesn't exist"
        erb :error
      elsif @client.payloads.empty?
        body "No payloads yet"
        erb :error
      else
        erb :"clients/show"
      end
    end

    get '/sources/:IDENTIFIER/urls/:RELATIVEPATH' do
      client = Client.find_by(identifier:params["IDENTIFIER"])
      @specific_url = client.urls.find_by(url: "#{client.root_url}/#{params[:RELATIVEPATH]}")

      if @specific_url.nil?
        body "Identifier doesn't exist"
        erb :error
      else
        erb :"clients/url"
      end
    end

    get '/sources/:IDENTIFIER/events/:EVENTNAME' do
      client = Client.find_by(identifier:params["IDENTIFIER"])
      event = Event.find_by(event:params["EVENTNAME"])
      @hourly = client.hourly_breakdown(event)

      erb :"clients/hourly_events"
    end
  end
end
