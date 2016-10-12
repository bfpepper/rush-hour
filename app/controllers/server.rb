module RushHour
  class Server < Sinatra::Base
    not_found do
      erb :error
    end

    post '/sources' do
      Client.validate_and_add_client(params)
    end

    post '/sources/:IDENTIFIER/data' do
      Payload.validate_and_add_payload(params)
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
